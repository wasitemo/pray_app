import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pray_app/provider/pray_provider.dart';
import 'package:pray_app/ui/widgets/pray_time_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayState = ref.watch(prayTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: prayState.when(
            data: (prayTime) => Text(prayTime.lokasi),
            error: (error, stack) => Text('Tidak dapat menemukan kota'),
            loading: () => const CircularProgressIndicator()),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(prayTimeProvider.notifier).loadData();
              },
              icon: Icon(Icons.location_on_sharp))
        ],
      ),
      body: SafeArea(
          child: prayState.when(
        data: (prayTime) => PrayTimeCard(prayTime: prayTime),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(error.toString()),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
      )),
    );
  }
}
