import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scanit/src/core/common/mocks/scans_mock.dart';
import 'package:scanit/src/features/scans/domain/scan_model.dart';
import 'package:scanit/src/features/scans/data/interface_scans_repository.dart';

part 'scans_repository.g.dart';

class ScansRepository implements InterfaceScansRepository {
  final _controller = StreamController<List<ScanModel>>.broadcast();

  // ----------------------- CRUD METHODS
  @override
  Future<void> createScan({required ScanModel scan}) async {
    final scans = await _loadAll();
    scans.add(scan);
    await _saveAll(scans);
  }

  @override
  Future<ScanModel?> readScan({required String scanId}) async {
    final scans = await _loadAll();
    return scans.firstWhereOrNull((s) => s.id == scanId);
  }

  @override
  Future<void> updateScan({
    required String oldScanId,
    required ScanModel updatedScan,
  }) async {
    final scans = await _loadAll();
    final index = scans.indexWhere((s) => s.id == oldScanId);
    if (index != -1) {
      scans[index] = updatedScan;
      await _saveAll(scans);
    }
  }

  @override
  Future<void> deleteScan({required String scanId}) async {
    final scans = await _loadAll();
    scans.removeWhere((s) => s.id == scanId);
    await _saveAll(scans);
  }

  // ----------------------- OTHER METHODS
  @override
  Stream<List<ScanModel>> scansStream() async* {
    final initialScans = await _loadAll();
    yield initialScans;
    yield* _controller.stream;
  }

  @override
  Stream<ScanModel?> scanStream({required String scanId}) async* {
    final initialScans = await _loadAll();
    yield initialScans.firstWhereOrNull((s) => s.id == scanId);

    yield* _controller.stream.map(
      (scans) => scans.firstWhereOrNull((s) => s.id == scanId),
    );
  }

  @override
  Future<void> loadMockScans() async {
    final mockScans = MockData.scans;
    await _saveAll(mockScans);
  }

  @override
  Future<void> deleteAllScans() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    _controller.add([]);
  }

  // ----------------------- HELPERS METHODS

  Future<void> _saveAll(List<ScanModel> scans) async {
    final path = await _getFilePath();
    final file = File(path);
    final json = jsonEncode(scans.map((e) => e.toJson()).toList());
    await file.writeAsString(json);
    _controller.add(scans);
  }

  Future<List<ScanModel>> _loadAll() async {
    final path = await _getFilePath();
    final file = File(path);
    if (!file.existsSync()) return [];
    final json = jsonDecode(await file.readAsString()) as List;
    return json.map((e) => ScanModel.fromJson(e)).toList();
  }

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/scans.json';
  }

  void dispose() {
    _controller.close();
  }
}

@riverpod
ScansRepository scansRepository(Ref ref) {
  final repo = ScansRepository();
  ref.onDispose(repo.dispose);
  return repo;
}

@riverpod
Stream<List<ScanModel>> scansStream(Ref ref) {
  final repo = ref.watch(scansRepositoryProvider);
  return repo.scansStream();
}

@riverpod
Stream<ScanModel?> scanStream(Ref ref, String scanId) {
  final repo = ref.watch(scansRepositoryProvider);
  return repo.scanStream(scanId: scanId);
}
