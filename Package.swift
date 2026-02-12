// swift-tools-version: 6.1
// This is a Skip (https://skip.dev) package that demonstrates
// testing a bridged Swift module using a transpiled test case
import PackageDescription

let package = Package(
    name: "skip-fuse-samples",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "SkipFuseSamples", type: .dynamic, targets: ["SkipFuseSamples"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.35"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.2")
    ],
    targets: [
        .target(name: "SkipFuseSamples", dependencies: [
            .product(name: "SkipFuse", package: "skip-fuse")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipFuseSamplesTests",
            dependencies: ["SkipFuseSamples", .product(name: "SkipTest", package: "skip")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
