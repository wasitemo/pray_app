import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_app/provider/pray_provider.dart';
import 'package:pray_app/ui/widgets/pray_time_card.dart';
import 'package:pray_app/ui/widgets/pray_time_location_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayState = ref.watch(prayTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PRAY APP',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SafeArea(
          child: prayState.when(
        data: (prayTime) => Column(
          children: [
            PrayTimeLocationCard(prayTime: prayTime),
            SizedBox(
              height: 20,
            ),
            PrayTimeCard(),
          ],
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(error.toString()),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
      )),
    );
  }
}
