// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "BTreeCustomDump",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .tvOS(.v13),
        .watchOS(.v7),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "BTreeCustomDump",
            targets: ["BTreeCustomDump"])
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BTree", from: "4.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.3"),
    ],
    targets: [
        .target(
            name: "BTreeCustomDump",
            dependencies: [
                "BTree",
                .product(name: "CustomDump", package: "swift-custom-dump")
            ],
            path: "Sources",
        ),
        .testTarget(
            name: "BTreeCustomDumpTests",
            dependencies: ["BTreeCustomDump"],
            path: "Tests",
        )
    ]
)
