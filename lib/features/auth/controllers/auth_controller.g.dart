// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'47c5dbac27795ba358958ef784ccebbf9879844f';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeFutureProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeFutureProviderRef<bool>;
String _$tabletOwnerClassHash() => r'e0cb335f559d868bec1eedccb364ff16e2d91a0c';

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
String _$authControllerHash() => r'f743f1f3b12f7f9fcb1b94c647c73a5d605a7f10';

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
