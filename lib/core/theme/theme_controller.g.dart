// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$systemBrightnessHash() => r'ae1c7f1fe4244e14d6ecff2a7e52d61f1b5e0020';

/// Provider to expose current system brightness
///
/// Copied from [systemBrightness].
@ProviderFor(systemBrightness)
final systemBrightnessProvider = AutoDisposeProvider<Brightness>.internal(
  systemBrightness,
  name: r'systemBrightnessProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$systemBrightnessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SystemBrightnessRef = AutoDisposeProviderRef<Brightness>;
String _$themeControllerHash() => r'f0d0c3f2dae983228560f8ef158c8fd98868b30c';

/// Controller for managing the app's theme
///
/// Copied from [ThemeController].
@ProviderFor(ThemeController)
final themeControllerProvider =
    AutoDisposeAsyncNotifierProvider<ThemeController, ITokens>.internal(
      ThemeController.new,
      name: r'themeControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$themeControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeController = AutoDisposeAsyncNotifier<ITokens>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
