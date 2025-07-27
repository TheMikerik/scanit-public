import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scanit/src/core/common/widgets/buttons/primary_button.dart';
import 'package:scanit/src/core/extensions/theme_data_extension.dart';
import 'package:scanit/src/features/scanner/presentation/scanner_screen.dart';
import 'package:scanit/src/features/scans/domain/scan_model.dart';
import 'package:scanit/src/features/scans/presentation/home/scan_tile_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({
    required this.scans,
    super.key,
  });
  final List<ScanModel> scans;

  @override
  Widget build(BuildContext context) {
    final favouriteScans = scans.where((s) => s.favorite).toList();

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            if (favouriteScans.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text('Favourite', style: context.text.titleMedium),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favouriteScans.length,
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ScanTileWidget(
                          scan: favouriteScans[index],
                          isSmall: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text('All scans', style: context.text.titleMedium),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: ScanTileWidget(scan: scans[index]),
                  );
                },
                childCount: scans.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
        Positioned(
          bottom: 50,
          left: 16,
          right: 16,
          child: Row(
            children: [
              PrimaryButton(
                text: 'Start scanning',
                onTap: () {
                  context.pushNamed(ScannerScreen.name);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
