import 'package:world_time/services/worldtime.dart';

class Region {
  static final List<WorldTime> locations = [
    WorldTime(
      location: 'africa',
      name: 'South Africa',
      city: 'Johannesburg',
      continent: 'Africa',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'albania',
      name: 'Albania',
      city: 'Tirana',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'argentina',
      name: 'Argentina',
      city: 'Buenos Aires',
      continent: 'Americas',
      gmt: '-03:00',
    ),
    WorldTime(
      location: 'australia',
      name: 'Australia',
      city: 'Sydney',
      continent: 'Oceania',
      gmt: '+11:00',
    ),
    WorldTime(
      location: 'bangladesh',
      name: 'Bangladesh',
      city: 'Dhaka',
      continent: 'Asia',
      gmt: '+06:00',
    ),
    WorldTime(
      location: 'belgium',
      name: 'Belgium',
      city: 'Brussels',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'bosnia',
      name: 'Bosnia & Herzegovina',
      city: 'Sarajevo',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'brazil',
      name: 'Brazil',
      city: 'São Paulo',
      continent: 'Americas',
      gmt: '-03:00',
    ),
    WorldTime(
      location: 'cameroon',
      name: 'Cameroon',
      city: 'Yaoundé',
      continent: 'Africa',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'canada',
      name: 'Canada',
      city: 'Toronto',
      continent: 'Americas',
      gmt: '-05:00',
    ),
    WorldTime(
      location: 'chad',
      name: 'Chad',
      city: 'N\'Djamena',
      continent: 'Africa',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'china',
      name: 'China',
      city: 'Beijing',
      continent: 'Asia',
      gmt: '+08:00',
    ),
    WorldTime(
      location: 'croatia',
      name: 'Croatia',
      city: 'Zagreb',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'czech',
      name: 'Czech Republic',
      city: 'Prague',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'denmark',
      name: 'Denmark',
      city: 'Copenhagen',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'estonia',
      name: 'Estonia',
      city: 'Tallinn',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'finland',
      name: 'Finland',
      city: 'Helsinki',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'france',
      name: 'France',
      city: 'Paris',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'germany',
      name: 'Germany',
      city: 'Berlin',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'greece',
      name: 'Greece',
      city: 'Athens',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'hungary',
      name: 'Hungary',
      city: 'Budapest',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'india',
      name: 'India',
      city: 'New Delhi',
      continent: 'Asia',
      gmt: '+05:30',
    ),
    WorldTime(
      location: 'ireland',
      name: 'Ireland',
      city: 'Dublin',
      continent: 'Europe',
      gmt: '+00:00',
    ),
    WorldTime(
      location: 'israel',
      name: 'Israel',
      city: 'Jerusalem',
      continent: 'Asia',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'italy',
      name: 'Italy',
      city: 'Rome',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'jamaica',
      name: 'Jamaica',
      city: 'Kingston',
      continent: 'Americas',
      gmt: '-05:00',
    ),
    WorldTime(
      location: 'korea',
      name: 'South Korea',
      city: 'Seoul',
      continent: 'Asia',
      gmt: '+09:00',
    ),
    WorldTime(
      location: 'latvia',
      name: 'Latvia',
      city: 'Riga',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'lithuania',
      name: 'Lithuania',
      city: 'Vilnius',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'luxembourg',
      name: 'Luxembourg',
      city: 'Luxembourg City',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'macedonia',
      name: 'North Macedonia',
      city: 'Skopje',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'netherlands',
      name: 'Netherlands',
      city: 'Amsterdam',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'norway',
      name: 'Norway',
      city: 'Oslo',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'poland',
      name: 'Poland',
      city: 'Warsaw',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'portugal',
      name: 'Portugal',
      city: 'Azores / Lisbon',
      continent: 'Europe',
      gmt: '-01:00',
    ),
    WorldTime(
      location: 'russia',
      name: 'Russia',
      city: 'Moscow',
      continent: 'Europe',
      gmt: '+03:00',
    ),
    WorldTime(
      location: 'slovakia',
      name: 'Slovakia',
      city: 'Bratislava',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'sweden',
      name: 'Sweden',
      city: 'Stockholm',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'switzerland',
      name: 'Switzerland',
      city: 'Bern',
      continent: 'Europe',
      gmt: '+01:00',
    ),
    WorldTime(
      location: 'turkey',
      name: 'Turkey',
      city: 'Istanbul',
      continent: 'Europe',
      gmt: '+03:00',
    ),
    WorldTime(
      location: 'uk',
      name: 'United Kingdom',
      city: 'London',
      continent: 'Europe',
      gmt: '+00:00',
    ),
    WorldTime(
      location: 'ukraine',
      name: 'Ukraine',
      city: 'Kyiv',
      continent: 'Europe',
      gmt: '+02:00',
    ),
    WorldTime(
      location: 'usa',
      name: 'United States',
      city: 'New York',
      continent: 'Americas',
      gmt: '-05:00',
    ),
  ];

  static List<String> get categories => [
    'All',
    'Favorites',
    'Americas',
    'Asia',
    'Europe',
    'Africa',
    'Oceania',
  ];

  static WorldTime findById(String id) {
    final normalized = id.toLowerCase().trim();
    return locations.firstWhere(
      (loc) => loc.id == normalized,
      orElse: () => locations.firstWhere(
        (loc) => loc.id == 'india',
        orElse: () => locations.first,
      ),
    );
  }

  static List<WorldTime> search({
    String query = '',
    String category = 'All',
    List<String> favoriteIds = const [],
  }) {
    final cleanQuery = query.toLowerCase().trim();

    return locations.where((loc) {
      if (category == 'Favorites') {
        if (!favoriteIds.contains(loc.id)) return false;
      } else if (category != 'All' && loc.continent != category) {
        return false;
      }

      if (cleanQuery.isEmpty) return true;

      return loc.name.toLowerCase().contains(cleanQuery) ||
          loc.city.toLowerCase().contains(cleanQuery) ||
          loc.id.toLowerCase().contains(cleanQuery) ||
          loc.continent.toLowerCase().contains(cleanQuery) ||
          loc.gmt.toLowerCase().contains(cleanQuery);
    }).toList();
  }
}
