// Copyright 2024–2025 Skip
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import Foundation
import SkipBridge
import SkipFuse
import SkipFuseSamples
import XCTest

class SkipFuseSamplesTests : XCTestCase {
    override func setUp() {
        #if SKIP
        // manually load the native library
        loadPeerLibrary(packageName: "skip-fuse-samples", moduleName: "SkipFuseSamples")
        #endif
    }

    func testBridgedSampleStruct() async throws {
        #if SKIP
        let id = java.util.UUID.randomUUID() // Java UUID, since the skip.yml is bridging with kotlincompat
        #else
        let id = Foundation.UUID() // Swift UUID
        #endif

        // the rest of this function run both transpiled for Android and natively for Darwin

        let x1 = try await SkipFuseSamplesModule.createBridgedSampleStruct(id: id)
        let x2 = try await SkipFuseSamplesModule.createBridgedSampleStruct(id: id)
        XCTAssertEqual(x1, x2)

        //XCTAssertEqual("Localized into English", x1.localizedString())
    }

    func testFuseCallbackImplementation() async throws {
        let handler: AsyncCallbackProtocol
        #if SKIP
        // transpiled to Kotlin
        handler = KotlinAsyncCallback()
        #else
        // execute natively
        handler = SwiftAsyncCallback()
        #endif

        // runs both transpiled and natively
        await AsyncCallbackProtocolHelper.invokeCallback(with: handler, param: AsyncCallbackParam())
    }
}

#if SKIP
final class KotlinAsyncCallback : AsyncCallbackProtocol {
    /// the `kotlincompat` bridged implementation of `Error` is `Throwable`
    override func callback(param: Throwable) async {
        print("KotlinAsyncCallback.callback: \(param)")
    }
}
#else
final class SwiftAsyncCallback : AsyncCallbackProtocol {
    func callback(param: Error) async {
        print("SwiftAsyncCallback.callback: \(param)")
    }
}
#endif
