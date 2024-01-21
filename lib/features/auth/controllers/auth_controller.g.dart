// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'a952a9cc8d50d48156ec0aeb535ffef3170546f9';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider =
    AutoDisposeFutureProvider<IsAuthenticatedModel>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeFutureProviderRef<IsAuthenticatedModel>;
String _$tabletOwnerClassHash() => r'53263546f555a5be27f05d9422701eb9baef8af6';

/// See also [TabletOwnerClass].
@ProviderFor(TabletOwnerClass)
final tabletOwnerClassProvider =
    AutoDisposeNotifierProvider<TabletOwnerClass, ClassModel?>.internal(
  TabletOwnerClass.new,
  name: r'tabletOwnerClassProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabletOwnerClassHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabletOwnerClass = AutoDisposeNotifier<ClassModel?>;
String _$classesDataHash() => r'69964cc7762363ac09655d657fb5aece57c68b36';

/// See also [ClassesData].
@ProviderFor(ClassesData)
final classesDataProvider =
    AutoDisposeNotifierProvider<ClassesData, List<ClassModel>>.internal(
  ClassesData.new,
  name: r'classesDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$classesDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ClassesData = AutoDisposeNotifier<List<ClassModel>>;
String _$authControllerHash() => r'88d71d1e8f90f88c7059d4071cbcb9a54f3e8a24';

/// See also [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeNotifierProvider<AuthController, bool>.internal(
  AuthController.new,
  name: r'authControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthController = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
