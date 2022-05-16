// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Box",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Box", targets: ["Box"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Box", dependencies: []),
        .testTarget(name: "BoxTests", dependencies: ["Box"]),
    ]
)
