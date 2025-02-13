import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:pray_app/model/pray_time.dart';

final formatterDate = DateFormat('dd, MMMM yyyy');
final formatterDay = DateFormat('EEEE');

class PrayNotifier extends StateNotifier<AsyncValue<PrayTime>> {
  PrayNotifier() : super(const AsyncValue.loading()) {
    loadData();
  }

  Timer? countdownTimer;
  String closestPrayer = "";
  Duration timeUntilNextPrayer = Duration.zero;

  Future<void> loadData() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      // Periksa apakah layanan lokasi aktif
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
        await Future.delayed(Duration(seconds: 2));
      }

      // Periksa apakah izin lokasi diberikan
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      // Ambil lokasi pengguna
      locationData = await location.getLocation();
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;

      // Format tanggal
      final formattedDate =
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";

      final url =
          Uri.http('192.168.1.101', '/api-waktu-sholat/public/index.php', {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "tanggal": formattedDate,
      });

      final response = await http.get(url);

      //get current time
      final DateTime now = DateTime.now();
      final currentDay = DateTime(now.day);
      final currentDate = DateTime(now.year, now.month, now.day);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Parsing data
        final lokasi = jsonData['data']['lokasi'];
        final subuh = jsonData['data']['subuh'];
        final dzuhur = jsonData['data']['dzuhur'];
        final ashar = jsonData['data']['ashar'];
        final maghrib = jsonData['data']['maghrib'];
        final isya = jsonData['data']['isya'];

        final data = PrayTime(
          hari: currentDay,
          tanggal: currentDate,
          lokasi: lokasi,
          subuh: subuh,
          dzuhur: dzuhur,
          ashar: ashar,
          maghrib: maghrib,
          isya: isya,
        );

        state = AsyncValue.data(data);
        updateClosestPrayer(data);
      } else {
        state = AsyncValue.error(
            "Failed to fetch data: ${response.statusCode}", StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void updateClosestPrayer(PrayTime prayTime) {
    final now = DateTime.now();
    final prayerTimes = {
      "Subuh": getPrayerTime(prayTime.subuh, prayTime.tanggal),
      "Dzuhur": getPrayerTime(prayTime.dzuhur, prayTime.tanggal),
      "Ashar": getPrayerTime(prayTime.ashar, prayTime.tanggal),
      "Maghrib": getPrayerTime(prayTime.maghrib, prayTime.tanggal),
      "Isya": getPrayerTime(prayTime.isya, prayTime.tanggal),
    };

    String nextPrayer = "Subuh";
    Duration minDiff = Duration(hours: 24);

    for (var entry in prayerTimes.entries) {
      final diff = entry.value.difference(now);
      if (diff.isNegative) continue;

      if (diff < minDiff) {
        minDiff = diff;
        nextPrayer = entry.key;
      }
    }

    closestPrayer = nextPrayer;
    timeUntilNextPrayer = minDiff;

    startCountdown();
  }

  DateTime getPrayerTime(String prayerTime, DateTime tanggal) {
    final parts = prayerTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(tanggal.year, tanggal.month, tanggal.day, hour, minute);
  }

  void startCountdown() {
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeUntilNextPrayer > Duration.zero) {
        timeUntilNextPrayer -= Duration(seconds: 1);
      } else {
        timer.cancel();
        loadData();
      }
      state = AsyncValue.data(state.value!);
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}

final prayTimeProvider =
    StateNotifierProvider<PrayNotifier, AsyncValue<PrayTime>>((ref) {
  return PrayNotifier();
});
