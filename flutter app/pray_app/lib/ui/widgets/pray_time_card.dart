import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_app/provider/pray_provider.dart';

class PrayTimeCard extends ConsumerStatefulWidget {
  const PrayTimeCard({
    super.key,
  });

  @override
  ConsumerState<PrayTimeCard> createState() => _PrayTimeCardState();
}

class _PrayTimeCardState extends ConsumerState<PrayTimeCard> {
  String closestPrayer = "";
  Duration countdown = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _startTimer();
  }

  void _updateCountdown() {
    setState(() {
      final prayNotifier = ref.read(prayTimeProvider.notifier);
      closestPrayer = prayNotifier.closestPrayer;
      countdown = prayNotifier.timeUntilNextPrayer;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          countdown = countdown - Duration(seconds: 1);
          if (countdown.isNegative) {
            _updateCountdown();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  @override
  Widget build(BuildContext context) {
    final prayState = ref.watch(prayTimeProvider);

    return prayState.when(
      data: (prayTime) {
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
              Center(
                child: Text(
                  '${countdown.inHours}:${(countdown.inMinutes % 60).toString().padLeft(2, '0')}:${(countdown.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  'Towards $closestPrayer',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildPrayerRow('Subuh', prayTime.subuh),
              buildPrayerRow('Dzuhur', prayTime.dzuhur),
              buildPrayerRow('Ashar', prayTime.ashar),
              buildPrayerRow('Maghrib', prayTime.maghrib),
              buildPrayerRow('Isya', prayTime.isya),
            ],
          ),
        );
      },
      error: (err, stack) => Center(child: Text('Error: $err')),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
