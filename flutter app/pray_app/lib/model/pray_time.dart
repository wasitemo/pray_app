import 'package:intl/intl.dart';

final formatterDate = DateFormat('dd, MMMM yyyy');
final formatterDay = DateFormat('EEEE');

class PrayTime {
  final DateTime hari;
  final DateTime tanggal;
  final String lokasi;
  final String subuh;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  const PrayTime({
    required this.hari,
    required this.tanggal,
    required this.lokasi,
    required this.subuh,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  String get formattedDate {
    return formatterDate.format(tanggal);
  }

  String get formattedDay {
    return formatterDay.format(hari);
  }

  // Fungsi untuk mengubah string waktu menjadi DateTime
  DateTime getPrayerTime(String prayerTime) {
    final parts = prayerTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(tanggal.year, tanggal.month, tanggal.day, hour, minute);
  }

  // Fungsi untuk mendapatkan waktu shalat terdekat
  String getClosestPrayer() {
    final now = DateTime.now();
    final prayerTimes = {
      "Subuh": getPrayerTime(subuh),
      "Dzuhur": getPrayerTime(dzuhur),
      "Ashar": getPrayerTime(ashar),
      "Maghrib": getPrayerTime(maghrib),
      "Isya": getPrayerTime(isya),
    };

    // Temukan waktu shalat terdekat
    String closestPrayer = "Subuh";
    Duration minDiff = Duration(hours: 24);

    for (var entry in prayerTimes.entries) {
      final diff = entry.value.difference(now);
      if (diff.isNegative) continue; // Lewati waktu yang sudah berlalu

      if (diff < minDiff) {
        minDiff = diff;
        closestPrayer = entry.key;
      }
    }

    return closestPrayer;
  }
}
