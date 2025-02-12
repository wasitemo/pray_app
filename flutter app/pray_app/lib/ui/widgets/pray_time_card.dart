import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pray_app/model/pray_time.dart';

class PrayTimeCard extends StatefulWidget {
  const PrayTimeCard({
    super.key,
    required this.prayTime,
  });

  final PrayTime prayTime;

  @override
  State<PrayTimeCard> createState() => _PrayTimeCardState();
}

class _PrayTimeCardState extends State<PrayTimeCard> {
  String closestPrayer = "";

  @override
  void initState() {
    super.initState();
    _updateClosestPrayer();
    _startTimer();
  }

  void _updateClosestPrayer() {
    setState(() {
      closestPrayer = widget.prayTime.getClosestPrayer();
    });
  }

  void _startTimer() {
    Timer.periodic(Duration(minutes: 1), (timer) {
      _updateClosestPrayer();
    });
  }

  Widget buildPrayerRow(String prayerName, String prayerTime) {
    final isHighlighted = prayerName == closestPrayer;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: isHighlighted
          ? BoxDecoration(
              color: Color.fromARGB(128, 34, 37, 49),
              borderRadius: BorderRadius.circular(26),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prayerName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            prayerTime.substring(0, 5),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 222, 103),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPrayerRow('Subuh', widget.prayTime.subuh),
          buildPrayerRow('Dzuhur', widget.prayTime.dzuhur),
          buildPrayerRow('Ashar', widget.prayTime.ashar),
          buildPrayerRow('Maghrib', widget.prayTime.maghrib),
          buildPrayerRow('Isya', widget.prayTime.isya),
        ],
      ),
    );
  }
}
