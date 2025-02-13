import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pray_app/model/pray_time.dart';

class PrayTimeLocationCard extends StatelessWidget {
  const PrayTimeLocationCard({
    super.key,
    required this.prayTime,
  });

  final PrayTime prayTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 222, 103),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prayTime.lokasi,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            DateFormat('EEEE').format(prayTime.hari),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            DateFormat('dd MMMM yyyy').format(prayTime.tanggal),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
