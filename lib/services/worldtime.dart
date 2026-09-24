import 'package:intl/intl.dart';

class WorldTime {
  final String id;
  final String name;
  final String city;
  final String continent;
  final String gmt;

  String time = '';
  String day = 'morning';

  WorldTime({
    required String location,
    required this.gmt,
    String? name,
    String? city,
    String? continent,
  }) : id = location.toLowerCase().trim(),
       name = name ?? _formatDefaultName(location),
       city = city ?? '',
       continent = continent ?? 'Other' {
    updateTime();
  }

  String get location => id;

  Duration get offsetDuration {
    try {
      final trimmed = gmt.trim();
      final isNegative = trimmed.startsWith('-');
      final clean = trimmed.replaceAll('+', '').replaceAll('-', '').trim();
      final parts = clean.split(':');
      final hours = int.parse(parts[0]);
      final minutes = parts.length > 1 ? int.parse(parts[1]) : 0;
      final totalMinutes = (hours * 60 + minutes) * (isNegative ? -1 : 1);
      return Duration(minutes: totalMinutes);
    } catch (_) {
      return Duration.zero;
    }
  }

  DateTime get currentTime {
    return DateTime.now().toUtc().add(offsetDuration);
  }

  void updateTime({DateTime? referenceTime}) {
    final now = referenceTime ?? currentTime;
    final hour = now.hour;

    if (hour >= 4 && hour < 10) {
      day = 'morning';
    } else if (hour >= 10 && hour < 13) {
      day = 'noon';
    } else if (hour >= 13 && hour < 16) {
      day = 'afternoon';
    } else if (hour >= 16 && hour < 21) {
      day = 'evening';
    } else {
      day = 'night';
    }

    time = DateFormat.jm().format(now);
  }

  Future<void> getTime() async {
    updateTime();
  }

  String formatTime({
    bool is24Hour = false,
    bool showSeconds = false,
    DateTime? now,
  }) {
    final target = now ?? currentTime;
    if (is24Hour) {
      return showSeconds
          ? DateFormat('HH:mm:ss').format(target)
          : DateFormat('HH:mm').format(target);
    } else {
      return showSeconds
          ? DateFormat('hh:mm:ss a').format(target)
          : DateFormat('hh:mm a').format(target);
    }
  }

  String formatDate({DateTime? now}) {
    final target = now ?? currentTime;
    return DateFormat('EEEE, d MMMM yyyy').format(target);
  }

  String get relativeTimeDifference {
    final localOffset = DateTime.now().timeZoneOffset;
    final diffMinutes = offsetDuration.inMinutes - localOffset.inMinutes;

    if (diffMinutes == 0) {
      return 'Same time as your device';
    }

    final absMinutes = diffMinutes.abs();
    final hours = absMinutes ~/ 60;
    final minutes = absMinutes % 60;

    final parts = <String>[];
    if (hours > 0) {
      parts.add('${hours}h');
    }
    if (minutes > 0 || hours == 0) {
      parts.add('${minutes}m');
    }

    final diffString = parts.join(' ');
    if (diffMinutes > 0) {
      return '$diffString ahead of local time';
    } else {
      return '$diffString behind local time';
    }
  }

  String get flagAssetPath => 'assets/flag/$id.png';

  String get timeAssetPath => 'assets/time/$day.png';

  String get periodTitle {
    switch (day) {
      case 'morning':
        return 'Morning';
      case 'noon':
        return 'Noon';
      case 'afternoon':
        return 'Afternoon';
      case 'evening':
        return 'Evening';
      case 'night':
      default:
        return 'Night';
    }
  }

  String get periodEmoji {
    switch (day) {
      case 'morning':
        return '🌅';
      case 'noon':
        return '☀️';
      case 'afternoon':
        return '🌤️';
      case 'evening':
        return '🌆';
      case 'night':
      default:
        return '🌙';
    }
  }

  static String _formatDefaultName(String raw) {
    if (raw.isEmpty) return '';
    return raw
        .split('_')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}
