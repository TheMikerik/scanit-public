import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:scanit/src/core/extensions/theme_data_extension.dart';
import 'package:scanit/src/features/scans/presentation/home/home_empty_widget.dart';
import 'package:scanit/src/features/scans/presentation/home/home_content_widget.dart';
import 'package:scanit/src/features/settings/presentation/settings_screen.dart';
import 'package:scanit/src/features/scans/data/scans_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const routePath = '/home';
  static const name = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStreamAsync = ref.watch(scansStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSettings01,
                color: context.color.onSurface,
              ),
              onPressed: () {
                context.goNamed(SettingsScreen.name);
              },
            ),
          ),
        ],
      ),
      body: scanStreamAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error in scanSteam: $e')),
        data: (scans) {
          if (scans.isEmpty) {
            return HomeEmptyWidget();
          }
          return HomeContentWidget(scans: scans);
        },
      ),
    );
  }
}
