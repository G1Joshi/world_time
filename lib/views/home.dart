import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:world_time/models/sharedprefs.dart';
import 'package:world_time/services/region.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/location.dart';

class Home extends StatefulWidget {
  final dynamic data;
  final WorldTime? initialLocation;

  const Home({super.key, this.data, this.initialLocation});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late WorldTime _currentLocation;
  Timer? _tickerTimer;
  bool _is24Hour = false;
  bool _isFavorite = false;
  List<WorldTime> _favoriteLocations = [];

  @override
  void initState() {
    super.initState();
    _resolveInitialLocation();
    _loadPreferences();
    _startClockTicker();
  }

  void _resolveInitialLocation() {
    if (widget.initialLocation != null) {
      _currentLocation = widget.initialLocation!;
    } else if (widget.data is WorldTime) {
      _currentLocation = widget.data as WorldTime;
    } else if (widget.data is Map) {
      final locId = (widget.data['location'] as String?) ?? 'india';
      _currentLocation = Region.findById(locId);
    } else {
      _currentLocation = Region.findById('india');
    }
    _currentLocation.updateTime();
  }

  void _loadPreferences() {
    _is24Hour = SharedPrefs.is24HourFormat;
    _syncFavorites();
  }

  void _syncFavorites() {
    _isFavorite = SharedPrefs.isFavorite(_currentLocation.id);
    final favIds = SharedPrefs.favorites;
    _favoriteLocations = favIds.map(Region.findById).toList();
    if (mounted) setState(() {});
  }

  void _startClockTicker() {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _currentLocation.updateTime();
      });
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    final nowFav = await SharedPrefs.toggleFavorite(_currentLocation.id);
    if (!mounted) return;
    setState(() {
      _isFavorite = nowFav;
      _syncFavorites();
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          nowFav
              ? '${_currentLocation.name} added to favorites'
              : '${_currentLocation.name} removed from favorites',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _toggleTimeFormat() async {
    final next = !_is24Hour;
    await SharedPrefs.set24HourFormat(next);
    if (!mounted) return;
    setState(() {
      _is24Hour = next;
    });
  }

  Future<void> _navigateToLocationPicker() async {
    final selected = await Navigator.of(context).push<WorldTime>(
      MaterialPageRoute(
        builder: (context) => Location(currentLocationId: _currentLocation.id),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        _currentLocation = selected;
        _currentLocation.updateTime();
        _syncFavorites();
      });
      await SharedPrefs.setData(selected.id, selected.gmt);
    }
  }

  void _selectLocation(WorldTime target) {
    if (_currentLocation.id == target.id) return;
    setState(() {
      _currentLocation = target;
      _currentLocation.updateTime();
      _syncFavorites();
    });
    SharedPrefs.setData(target.id, target.gmt);
  }

  @override
  Widget build(BuildContext context) {
    final now = _currentLocation.currentTime;
    final timeStr = _currentLocation.formatTime(
      is24Hour: _is24Hour,
      showSeconds: false,
      now: now,
    );
    final secondsStr = now.second.toString().padLeft(2, '0');
    final dateStr = _currentLocation.formatDate(now: now);
    final diffStr = _currentLocation.relativeTimeDifference;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child: Image.asset(
              _currentLocation.timeAssetPath,
              key: ValueKey(_currentLocation.timeAssetPath),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFF1E293B));
              },
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTopBar(),

                        const SizedBox(height: 16),

                        _buildHeroGlassClock(
                          timeStr: timeStr,
                          secondsStr: secondsStr,
                          dateStr: dateStr,
                          diffStr: diffStr,
                        ),

                        const SizedBox(height: 24),

                        _buildFavoritesBar(),

                        const SizedBox(height: 16),

                        _buildChooseLocationButton(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _currentLocation.periodEmoji,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _currentLocation.periodTitle.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _toggleTimeFormat,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _is24Hour ? '24H' : '12H',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            IconButton(
              iconSize: 26,
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.35),
                foregroundColor: _isFavorite
                    ? Colors.amberAccent
                    : Colors.white,
                side: BorderSide(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              onPressed: _toggleFavorite,
              tooltip: _isFavorite
                  ? 'Remove from favorites'
                  : 'Add to favorites',
              icon: Icon(
                _isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroGlassClock({
    required String timeStr,
    required String secondsStr,
    required String dateStr,
    required String diffStr,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.28),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'flag_${_currentLocation.id}',
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      _currentLocation.flagAssetPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.flag_rounded,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                _currentLocation.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),

              if (_currentLocation.city.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '${_currentLocation.city} • ${_currentLocation.continent}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],

              const SizedBox(height: 28),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      timeStr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 68.0,
                        letterSpacing: -1.0,
                        fontFeatures: [FontFeature.tabularFigures()],
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            offset: Offset(0, 4),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ':$secondsStr',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                        fontFeatures: const [FontFeature.tabularFigures()],
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text(
                dateStr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 15,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'GMT${_currentLocation.gmt} • $diffStr',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesBar() {
    if (_favoriteLocations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PINNED CLOCKS',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                '${_favoriteLocations.length} locations',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 68,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _favoriteLocations.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final loc = _favoriteLocations[index];
              final isCurrent = loc.id == _currentLocation.id;
              final locTime = loc.formatTime(
                is24Hour: _is24Hour,
                showSeconds: false,
              );

              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => _selectLocation(loc),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? Colors.white.withValues(alpha: 0.25)
                          : Colors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isCurrent
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.15),
                        width: isCurrent ? 1.6 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            loc.flagAssetPath,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.flag,
                                  size: 20,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              locTime,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChooseLocationButton() {
    return ElevatedButton.icon(
      onPressed: _navigateToLocationPicker,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.22),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
      ),
      icon: const Icon(Icons.explore_rounded, size: 22),
      label: const Text(
        'Explore All Locations',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
