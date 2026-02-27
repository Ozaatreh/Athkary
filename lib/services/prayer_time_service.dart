import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';

class PrayerTimeService {
  static Map<String, DateTime> getPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) {
    final params =
        CalculationMethod.muslim_world_league.getParameters();

    final coordinates = Coordinates(latitude, longitude);
    final today = date ?? DateTime.now();

    final prayerTimes = PrayerTimes(
      coordinates,
      DateComponents(today.year, today.month, today.day),
      params,
    );

    return {
      "الفجر": prayerTimes.fajr,
      "الشروق": prayerTimes.sunrise,
      "الظهر": prayerTimes.dhuhr,
      "العصر": prayerTimes.asr,
      "المغرب": prayerTimes.maghrib.add(const Duration(minutes: 4)),
      "العشاء": prayerTimes.isha.add(const Duration(minutes: 5)),
    };
  }

  static Map<String, String> formatPrayerTimes(
      Map<String, DateTime> times) {
    return times.map(
      (key, value) =>
          MapEntry(key, DateFormat.jm().format(value)),
    );
  }
}