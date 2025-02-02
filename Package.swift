// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "OuDiaKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
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
