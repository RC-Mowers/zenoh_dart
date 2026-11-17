import 'dart:ffi';

/// The `native/linux/<arch>` directory name for the host running the suite,
/// as `uname -m` and the CMake install rule name it.
///
/// The suite used to name `x86_64` and `build/linux-x64` literally, so on an
/// arm64 host every test that reads the generated headers or links a native
/// helper failed before it reached the code under test.
String get hostNativeArch => switch (Abi.current()) {
  Abi.linuxX64 => 'x86_64',
  Abi.linuxArm64 => 'aarch64',
  final abi => throw UnsupportedError(
    'The test suite runs on Linux x64 or arm64, not $abi.',
  ),
};

/// The CMake preset, and `build/` directory, for the host's unstable full
/// build. The stable build adds `-stable`.
String get hostPreset => switch (Abi.current()) {
  Abi.linuxX64 => 'linux-x64',
  Abi.linuxArm64 => 'linux-arm64',
  final abi => throw UnsupportedError(
    'The test suite runs on Linux x64 or arm64, not $abi.',
  ),
};

/// The build-tree generated zenoh-c headers of one variant, relative to
/// `package/`.
String buildTreeIncludeDir({required bool stable}) =>
    '../build/$hostPreset${stable ? '-stable' : ''}/extern/zenoh-c/release/include';

/// A variant's native library directory, relative to `package/`.
String nativeLibDir(String variant) => 'native/linux/$hostNativeArch/$variant';
