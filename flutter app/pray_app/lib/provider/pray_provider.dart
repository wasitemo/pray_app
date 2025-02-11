import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:pray_app/model/pray_time.dart';

class PrayNotifier extends StateNotifier<AsyncValue<PrayTime>> {
  PrayNotifier() : super(const AsyncValue.loading());

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

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Parsing data
        final lokasi = jsonData['data']['lokasi'].toString();
        final subuh = jsonData['data']['subuh'].toString();
        final dzuhur = jsonData['data']['dzuhur'].toString();
        final ashar = jsonData['data']['ashar'].toString();
        final maghrib = jsonData['data']['maghrib'].toString();
        final isya = jsonData['data']['isya'].toString();

        // Perbarui state
        state = AsyncValue.data(
          PrayTime(
            lokasi: lokasi,
            subuh: subuh,
            dzuhur: dzuhur,
            ashar: ashar,
            maghrib: maghrib,
            isya: isya,
          ),
        );
      } else {
        state = AsyncValue.error(
            "Failed to fetch data: ${response.statusCode}", StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final prayTimeProvider =
    StateNotifierProvider<PrayNotifier, AsyncValue<PrayTime>>((ref) {
  return PrayNotifier()..loadData();
});
