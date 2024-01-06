// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classLocalAPIHash() => r'ac2f8ac9692a393d3b0b9a35c26b5796a4af7c9f';

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

/// See also [classLocalAPI].
@ProviderFor(classLocalAPI)
const classLocalAPIProvider = ClassLocalAPIFamily();

/// See also [classLocalAPI].
class ClassLocalAPIFamily extends Family<ClassLocalAPI> {
  /// See also [classLocalAPI].
  const ClassLocalAPIFamily();

  /// See also [classLocalAPI].
  ClassLocalAPIProvider call(
    SharedPreferences sharedPrefs,
  ) {
    return ClassLocalAPIProvider(
      sharedPrefs,
    );
  }

  @override
  ClassLocalAPIProvider getProviderOverride(
    covariant ClassLocalAPIProvider provider,
  ) {
    return call(
      provider.sharedPrefs,
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
  String? get name => r'classLocalAPIProvider';
}

/// See also [classLocalAPI].
class ClassLocalAPIProvider extends AutoDisposeProvider<ClassLocalAPI> {
  /// See also [classLocalAPI].
  ClassLocalAPIProvider(
    SharedPreferences sharedPrefs,
  ) : this._internal(
          (ref) => classLocalAPI(
            ref as ClassLocalAPIRef,
            sharedPrefs,
          ),
          from: classLocalAPIProvider,
          name: r'classLocalAPIProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$classLocalAPIHash,
          dependencies: ClassLocalAPIFamily._dependencies,
          allTransitiveDependencies:
              ClassLocalAPIFamily._allTransitiveDependencies,
          sharedPrefs: sharedPrefs,
        );

  ClassLocalAPIProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sharedPrefs,
  }) : super.internal();

  final SharedPreferences sharedPrefs;

  @override
  Override overrideWith(
    ClassLocalAPI Function(ClassLocalAPIRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ClassLocalAPIProvider._internal(
        (ref) => create(ref as ClassLocalAPIRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sharedPrefs: sharedPrefs,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ClassLocalAPI> createElement() {
    return _ClassLocalAPIProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassLocalAPIProvider && other.sharedPrefs == sharedPrefs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sharedPrefs.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClassLocalAPIRef on AutoDisposeProviderRef<ClassLocalAPI> {
  /// The parameter `sharedPrefs` of this provider.
  SharedPreferences get sharedPrefs;
}

class _ClassLocalAPIProviderElement
    extends AutoDisposeProviderElement<ClassLocalAPI> with ClassLocalAPIRef {
  _ClassLocalAPIProviderElement(super.provider);

  @override
  SharedPreferences get sharedPrefs =>
      (origin as ClassLocalAPIProvider).sharedPrefs;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
