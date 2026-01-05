// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception

import Foundation
import Observation
#if os(Android) || ROBOLECTRIC
import SkipFuse
#endif

public class SkipFuseSamplesModule {
    public static func createBridgedSampleStruct(id: UUID, delay: Double? = nil) async throws -> BridgedSampleStruct {
        if let delay = delay {
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
        return BridgedSampleStruct(id: id)
    }

    /// An example of a type that can be bridged between Swift and Kotlin
    public struct BridgedSampleStruct: Identifiable, Hashable, Codable {
        public var id: UUID

        public func localizedString() -> String {
            //AndroidLocalizedString()("localized", bundle: .module, comment: "localized string example")
            NSLocalizedString("localized", bundle: .module, comment: "localized string example")

            //String(localized: "localized", bundle: .module, comment: "localized string example")

            //String(localized: <#T##StaticString#>, options: <#T##String.LocalizationOptions#>, table: <#T##String?#>, bundle: <#T##Bundle?#>, locale: <#T##Locale#>, comment: <#T##StaticString?#>)

        }
    }
}

public class MainActorClosureHolder {
    public var mainActorClosure: @MainActor () -> Void = { }

    public init(mainActorClosure: @escaping @MainActor () -> Void) {
        self.mainActorClosure = mainActorClosure
    }
}

public protocol AsyncCallbackProtocol : AnyObject, Sendable {
    func callback(param: Error) async
}

public struct AsyncCallbackParam : Sendable, Error {
    public init() {
    }
}

public class AsyncCallbackProtocolHelper {
    public static func invokeCallback(with handler: AsyncCallbackProtocol, param: Error) async {
        await handler.callback(param: param)
    }
}

public typealias AsyncVoidCallback = @MainActor () async -> ()
public typealias VoidCallback = @MainActor () -> ()
public typealias StringCallback = @MainActor (String) -> ()

public struct Callbacks: @unchecked Sendable {
    let didLogin: AsyncVoidCallback
    let didCancel: AsyncVoidCallback
    let didSelectEmail: StringCallback
    let didSelectSettings: VoidCallback

    public init(
        didLogin: @escaping AsyncVoidCallback = {},
        didCancel: @escaping AsyncVoidCallback = {},
        didSelectEmail: @escaping StringCallback = { _ in },
        didSelectSettings: @escaping VoidCallback = {},
    ) {
        self.didLogin = didLogin
        self.didCancel = didCancel
        self.didSelectEmail = didSelectEmail
        self.didSelectSettings = didSelectSettings
    }
}
