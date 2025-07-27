// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scans_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scansRepositoryHash() => r'342483c6cc7e6306298f640e25a4504082af94d3';

/// See also [scansRepository].
@ProviderFor(scansRepository)
final scansRepositoryProvider = AutoDisposeProvider<ScansRepository>.internal(
  scansRepository,
  name: r'scansRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scansRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScansRepositoryRef = AutoDisposeProviderRef<ScansRepository>;
String _$scansStreamHash() => r'4575b99ffdc12c04fa454ec96855daf18647c523';

/// See also [scansStream].
@ProviderFor(scansStream)
final scansStreamProvider = AutoDisposeStreamProvider<List<ScanModel>>.internal(
  scansStream,
  name: r'scansStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$scansStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ScansStreamRef = AutoDisposeStreamProviderRef<List<ScanModel>>;
String _$scanStreamHash() => r'06d693ebbf39fffc3a65d35b5eda48ddc78f794b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [scanStream].
@ProviderFor(scanStream)
const scanStreamProvider = ScanStreamFamily();

/// See also [scanStream].
class ScanStreamFamily extends Family<AsyncValue<ScanModel?>> {
  /// See also [scanStream].
  const ScanStreamFamily();

  /// See also [scanStream].
  ScanStreamProvider call(
    String scanId,
  ) {
    return ScanStreamProvider(
      scanId,
    );
  }

  @override
  ScanStreamProvider getProviderOverride(
    covariant ScanStreamProvider provider,
  ) {
    return call(
      provider.scanId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scanStreamProvider';
}

/// See also [scanStream].
class ScanStreamProvider extends AutoDisposeStreamProvider<ScanModel?> {
  /// See also [scanStream].
  ScanStreamProvider(
    String scanId,
  ) : this._internal(
          (ref) => scanStream(
            ref as ScanStreamRef,
            scanId,
          ),
          from: scanStreamProvider,
          name: r'scanStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scanStreamHash,
          dependencies: ScanStreamFamily._dependencies,
          allTransitiveDependencies:
              ScanStreamFamily._allTransitiveDependencies,
          scanId: scanId,
        );

  ScanStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scanId,
  }) : super.internal();

  final String scanId;

  @override
  Override overrideWith(
    Stream<ScanModel?> Function(ScanStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ScanStreamProvider._internal(
        (ref) => create(ref as ScanStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scanId: scanId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ScanModel?> createElement() {
    return _ScanStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScanStreamProvider && other.scanId == scanId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scanId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScanStreamRef on AutoDisposeStreamProviderRef<ScanModel?> {
  /// The parameter `scanId` of this provider.
  String get scanId;
}

class _ScanStreamProviderElement
    extends AutoDisposeStreamProviderElement<ScanModel?> with ScanStreamRef {
  _ScanStreamProviderElement(super.provider);

  @override
  String get scanId => (origin as ScanStreamProvider).scanId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
