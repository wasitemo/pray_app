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
  Duration timeUntilNextPrayer = Duration.zero;
  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();
    _updateClosestPrayer();
    _startTimer();
  }

  void _updateClosestPrayer() {
    setState(() {
      closestPrayer = widget.prayTime.getClosestPrayer();
      timeUntilNextPrayer = widget.prayTime.getTimeUntilNextPrayer();
    });
  }

  void _startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          timeUntilNextPrayer = widget.prayTime.getTimeUntilNextPrayer();
        });
      }
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
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

  Widget buildCountdown() {
    final hours = timeUntilNextPrayer.inHours;
    final minutes =
        (timeUntilNextPrayer.inMinutes % 60).toString().padLeft(2, '0');
    final seconds =
        (timeUntilNextPrayer.inSeconds % 60).toString().padLeft(2, '0');

    return Center(
      child: Text(
        'Waktu menuju $closestPrayer: $hours:$minutes:$seconds',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
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
          buildCountdown(),
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
