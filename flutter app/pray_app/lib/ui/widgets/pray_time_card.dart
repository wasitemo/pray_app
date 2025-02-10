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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(26)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prayTime.subuh),
          Text(prayTime.dzuhur),
          Text(prayTime.ashar),
          Text(prayTime.maghrib),
          Text(prayTime.isya)
        ],
      ),
    );
  }
}
