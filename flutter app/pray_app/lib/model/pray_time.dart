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
}
