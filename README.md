# SkipFuseSamples

This project demonstrates a native Swift SkipFuse library that can
be built for both Android and Darwin platforms, as well as
a transpiled `SkipFuseSamplesTests` module that demonstrates
accessing the bridged Swift from the Kotlin.

The main components of this package are:

- [Sources/SkipFuseSamples/SkipFuseSamples.swift](Sources/SkipFuseSamples/SkipFuseSamples.swift): a natively-compiled Swift file that contains some example functionality.
- [Sources/SkipFuseSamples/Skip/skip.yml](Sources/SkipFuseSamples/Skip/skip.yml): the Skip configuration file that indicates that the `SkipFuseSamples` module should be compiled natively and bridged using the [`kotlincompat`](https://skip.tools/docs/bridging/) mode.
- [Tests/SkipFuseSamplesTests/SkipFuseSamplesTests.swift](Tests/SkipFuseSamplesTests/SkipFuseSamplesTests.swift): the test cases that will be run both natively on Darwin platforms, and transpiled to Kotlin to test bridged structures on Android
- [.github/workflows/ci.yml](.github/workflows/ci.yml): GitHub continuous integration that runs test cases against macOS, iOS, and Android.

Tests can be run locally from Xcode, which will build and
run using the local JVM on the macOS host using the Robolectic
Android emulation libraries. To run tests against an actual
Android emulator or device, set the environment `ANDROID_SERIAL`
to the identifier of the emulator (usually "emulator-5554") or device
and then run the test cases. See 
[https://skip.tools/docs/testing](https://skip.tools/docs/testing)
for testing details, and for more information on creating a
hybrid project that follows this project's structure', see
[https://skip.tools/blog/skip-native-tech-preview/](https://skip.tools/blog/skip-native-tech-preview/).

Tests can also be run locally from the command-line with:

```
swift test
```

and against an emulator with:

```
ANDROID_SERIAL=emulator-5554 swift test
```


## Building

This project is a free Swift Package Manager module that uses the
[Skip](https://skip.tools) plugin to transpile Swift into Kotlin.

Building the module requires that Skip be installed using
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.
This will also install the necessary build prerequisites:
Kotlin, Gradle, and the Android build tools.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.

## License

This software is licensed under the
[GNU Lesser General Public License v3.0](https://spdx.org/licenses/LGPL-3.0-only.html),
with a [linking exception](https://spdx.org/licenses/LGPL-3.0-linking-exception.html)
to clarify that distribution to restricted environments (e.g., app stores) is permitted.
