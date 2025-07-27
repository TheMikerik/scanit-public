import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:scanit/src/core/common/widgets/buttons/primary_button.dart';
import 'package:scanit/src/core/extensions/theme_data_extension.dart';
import 'package:scanit/src/core/resources/assets.dart';
import 'package:scanit/src/features/scanner/presentation/scanner_screen.dart';

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 280,
              child: Lottie.asset(
                LottieAssets.emptyStateLottie,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'No 3D scans yet',
              style: context.text.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Start scanning to capture your first 3D object!',
              style: context.text.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Text(
              'Capture • Preview • Export',
              style: context.text.labelLarge?.copyWith(
                color: context.color.onSurface.withAlpha(100),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                PrimaryButton(
                  text: 'Start scanning',
                  onTap: () => context.pushNamed(ScannerScreen.name),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
