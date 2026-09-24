import 'package:flutter/material.dart';
import 'package:world_time/models/sharedprefs.dart';
import 'package:world_time/services/region.dart';
import 'package:world_time/services/worldtime.dart';

class Location extends StatefulWidget {
  final String? currentLocationId;

  const Location({super.key, this.currentLocationId});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<WorldTime> _filteredLocations = [];
  List<String> _favoriteIds = [];

  @override
  void initState() {
    super.initState();
    _favoriteIds = SharedPrefs.favorites;
    _applyFilter();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    setState(() {
      _filteredLocations = Region.search(
        query: _searchController.text,
        category: _selectedCategory,
        favoriteIds: _favoriteIds,
      );
    });
  }

  Future<void> _toggleFavorite(WorldTime loc) async {
    final isNowFav = await SharedPrefs.toggleFavorite(loc.id);
    setState(() {
      _favoriteIds = SharedPrefs.favorites;
      _applyFilter();
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isNowFav
              ? '${loc.name} added to favorites'
              : '${loc.name} removed from favorites',
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _selectLocation(WorldTime loc) {
    Navigator.of(context).pop(loc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Choose Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF1E293B),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => _applyFilter(),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.lightBlueAccent,
                  decoration: InputDecoration(
                    hintText: 'Search city, country, or timezone...',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white70,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _applyFilter();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFF334155),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: Region.categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final cat = Region.categories[index];
                      final isSelected = cat == _selectedCategory;

                      return FilterChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (cat == 'Favorites') ...[
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: isSelected
                                    ? Colors.amberAccent
                                    : Colors.amber,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(cat),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = cat;
                            _applyFilter();
                          });
                        },
                        backgroundColor: const Color(0xFF334155),
                        selectedColor: Colors.blueAccent.shade700,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.lightBlueAccent
                                : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredLocations.length} ${_filteredLocations.length == 1 ? "LOCATION" : "LOCATIONS"} FOUND',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  _selectedCategory.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _filteredLocations.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                    itemCount: _filteredLocations.length,
                    itemBuilder: (context, index) {
                      final loc = _filteredLocations[index];
                      final isCurrent =
                          widget.currentLocationId != null &&
                          loc.id == widget.currentLocationId;
                      final isFav = _favoriteIds.contains(loc.id);
                      final currentTimeStr = loc.formatTime(
                        is24Hour: SharedPrefs.is24HourFormat,
                        showSeconds: false,
                      );

                      return Card(
                        color: isCurrent
                            ? const Color(0xFF1E3A8A).withValues(alpha: 0.7)
                            : const Color(0xFF1E293B),
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: isCurrent
                                ? Colors.lightBlueAccent
                                : Colors.white.withValues(alpha: 0.08),
                            width: isCurrent ? 1.5 : 1.0,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => _selectLocation(loc),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isCurrent
                                          ? Colors.lightBlueAccent
                                          : Colors.white.withValues(alpha: 0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      loc.flagAssetPath,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.flag_rounded,
                                                color: Colors.white70,
                                              ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              loc.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: isCurrent
                                                    ? FontWeight.bold
                                                    : FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (isCurrent) ...[
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlueAccent
                                                    .withValues(alpha: 0.2),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: const Text(
                                                'ACTIVE',
                                                style: TextStyle(
                                                  color: Colors.lightBlueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 9,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${loc.city} • GMT${loc.gmt}',
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.65,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      currentTimeStr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      loc.periodEmoji,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4),

                                IconButton(
                                  icon: Icon(
                                    isFav
                                        ? Icons.star_rounded
                                        : Icons.star_border_rounded,
                                    color: isFav
                                        ? Colors.amberAccent
                                        : Colors.white38,
                                    size: 24,
                                  ),
                                  onPressed: () => _toggleFavorite(loc),
                                  tooltip: isFav
                                      ? 'Remove favorite'
                                      : 'Add to favorites',
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
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 72,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Locations Found',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try changing your search terms or category filter.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF334155),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _selectedCategory = 'All';
                  _applyFilter();
                });
              },
              child: const Text('Reset Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
