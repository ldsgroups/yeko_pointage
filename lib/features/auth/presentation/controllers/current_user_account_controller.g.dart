// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'1928ec05e9cdce20ccf935b6382025d389cb83b4';

/// See also [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeFutureProvider<UserEntity?>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthenticatedRef = AutoDisposeFutureProviderRef<UserEntity?>;
String _$currentUserAccountControllerHash() =>
    r'd4ac67036682e99bb8fa04a78e1ccb72d956079a';

/// See also [CurrentUserAccountController].
@ProviderFor(CurrentUserAccountController)
final currentUserAccountControllerProvider =
    AutoDisposeNotifierProvider<CurrentUserAccountController, bool>.internal(
  CurrentUserAccountController.new,
  name: r'currentUserAccountControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserAccountControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentUserAccountController = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
