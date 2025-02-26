// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "OuDiaKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "OuDiaKit",
            targets: ["OuDiaKit"]
        ),
    ],
    targets: [
        .target(
            name: "OuDiaKit"
        ),
        .testTarget(
            name: "OuDiaKitTests",
            dependencies: ["OuDiaKit"]
        ),
    ]
)
