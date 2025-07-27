import 'package:scanit/src/features/scans/domain/scan_model.dart';

abstract class InterfaceScansRepository {
  Future<void> createScan({
    required ScanModel scan,
  });

  Future<ScanModel?> readScan({
    required String scanId,
  });

  Future<void> updateScan({
    required String oldScanId,
    required ScanModel updatedScan,
  });

  Future<void> deleteScan({
    required String scanId,
  });

  Stream<List<ScanModel>> scansStream();
  Stream<ScanModel?> scanStream({required String scanId});

  Future<void> loadMockScans();
  Future<void> deleteAllScans();
}
