// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IDNectCardUI",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "IDNectCardUI",
            targets: ["IDNectCardUI"]
        )
    ],
    targets: [
        .target(
            name: "IDNectCardUI",
            dependencies: [],
            path: "Sources/IDNectCardUI"
        )
    ]
)
