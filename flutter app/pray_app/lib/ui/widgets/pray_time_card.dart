import 'package:flutter/material.dart';
import 'package:pray_app/model/pray_time.dart';

class PrayTimeCard extends StatelessWidget {
  const PrayTimeCard({
    super.key,
    required this.prayTime,
  });

  final PrayTime prayTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 322,
      height: 144,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(26)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subuh: ${prayTime.subuh.substring(0, 5)}'),
          Text('Dzuhur: ${prayTime.dzuhur.substring(0, 5)}'),
          Text('Ashar: ${prayTime.ashar.substring(0, 5)}'),
          Text('Maghrib: ${prayTime.maghrib.substring(0, 5)}'),
          Text('Isya: ${prayTime.isya.substring(0, 5)}')
        ],
      ),
    );
  }
}
