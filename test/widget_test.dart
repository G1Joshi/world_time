import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:world_time/models/sharedprefs.dart';
import 'package:world_time/services/region.dart';
import 'package:world_time/services/worldtime.dart';
import 'package:world_time/views/home.dart';
import 'package:world_time/views/location.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'location': 'india',
      'gmt': '+05:30',
      'favorite_locations': <String>[],
      'is_24_hour': false,
    });
    await SharedPrefs.init();
  });

  group('WorldTime Model Tests', () {
    test('Correctly parses positive offset duration', () {
      final wt = WorldTime(location: 'india', gmt: '+05:30');
      expect(wt.offsetDuration.inMinutes, 330);
    });

    test('Correctly parses negative offset duration', () {
      final wt = WorldTime(location: 'usa', gmt: '-05:00');
      expect(wt.offsetDuration.inMinutes, -300);
    });

    test(
      'Correctly determines day period for morning, noon, evening, night',
      () {
        final wt = WorldTime(location: 'india', gmt: '+05:30');

        wt.updateTime(referenceTime: DateTime(2026, 9, 24, 7, 0));
        expect(wt.day, 'morning');

        wt.updateTime(referenceTime: DateTime(2026, 9, 24, 11, 30));
        expect(wt.day, 'noon');

        wt.updateTime(referenceTime: DateTime(2026, 9, 24, 14, 0));
        expect(wt.day, 'afternoon');

        wt.updateTime(referenceTime: DateTime(2026, 9, 24, 18, 0));
        expect(wt.day, 'evening');

        wt.updateTime(referenceTime: DateTime(2026, 9, 24, 23, 0));
        expect(wt.day, 'night');
      },
    );

    test('Correctly formats 12H and 24H times', () {
      final wt = WorldTime(location: 'uk', gmt: '+00:00');
      final refTime = DateTime(2026, 9, 24, 15, 45, 30);

      expect(
        wt.formatTime(is24Hour: false, showSeconds: false, now: refTime),
        '03:45 PM',
      );
      expect(
        wt.formatTime(is24Hour: true, showSeconds: false, now: refTime),
        '15:45',
      );
      expect(
        wt.formatTime(is24Hour: true, showSeconds: true, now: refTime),
        '15:45:30',
      );
    });
  });

  group('Region Catalog & Search Tests', () {
    test('Contains 43 world locations', () {
      expect(Region.locations.length, 43);
    });

    test('Finds location by id with fallback', () {
      final india = Region.findById('india');
      expect(india.name, 'India');
      expect(india.continent, 'Asia');

      final unknown = Region.findById('atlantis');
      expect(unknown.id, 'india');
    });

    test('Filters by continent category', () {
      final europe = Region.search(category: 'Europe');
      expect(europe.every((loc) => loc.continent == 'Europe'), isTrue);
      expect(europe.isNotEmpty, isTrue);
    });

    test('Searches by keyword query', () {
      final results = Region.search(query: 'york');
      expect(results.length, 1);
      expect(results.first.id, 'usa');
    });

    test('Filters favorites accurately', () {
      final favs = Region.search(
        category: 'Favorites',
        favoriteIds: ['india', 'uk'],
      );
      expect(favs.length, 2);
      expect(favs.map((e) => e.id), containsAll(['india', 'uk']));
    });
  });

  group('SharedPrefs Integration Tests', () {
    test('Favorites list starts empty by default', () {
      expect(SharedPrefs.favorites, isEmpty);
    });

    test('Toggles favorite state correctly', () async {
      expect(SharedPrefs.isFavorite('france'), isFalse);
      final added = await SharedPrefs.toggleFavorite('france');
      expect(added, isTrue);
      expect(SharedPrefs.isFavorite('france'), isTrue);

      final removed = await SharedPrefs.toggleFavorite('france');
      expect(removed, isFalse);
      expect(SharedPrefs.isFavorite('france'), isFalse);
    });

    test('Stores and retrieves 24-hour preference', () async {
      expect(SharedPrefs.is24HourFormat, isFalse);
      await SharedPrefs.set24HourFormat(true);
      expect(SharedPrefs.is24HourFormat, isTrue);
    });
  });

  group('UI Widget Tests', () {
    testWidgets('Home renders country, city, and action buttons', (
      WidgetTester tester,
    ) async {
      final india = Region.findById('india');
      await tester.pumpWidget(MaterialApp(home: Home(initialLocation: india)));

      expect(find.text('India'), findsWidgets);
      expect(find.textContaining('New Delhi'), findsOneWidget);
      expect(find.text('Explore All Locations'), findsOneWidget);

      expect(find.text('PINNED CLOCKS'), findsNothing);

      await tester.tap(find.byTooltip('Add to favorites'));
      await tester.pump();
      expect(find.text('PINNED CLOCKS'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('Location picker displays search and filters locations', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Location(currentLocationId: 'africa')),
      );

      expect(find.text('Choose Location'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('ACTIVE'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'japan');
      await tester.pump();
      expect(find.text('No Locations Found'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'london');
      await tester.pump();
      expect(find.text('United Kingdom'), findsOneWidget);
    });
  });
}
