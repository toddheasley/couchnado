// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "couch-data", platforms: [
    .macOS(.v10_16),
    .iOS(.v14),
    .tvOS(.v14)
], products: [
    .library(name: "CouchData", targets: [
        "CouchData"
    ]),
    .executable(name: "couch-tidy", targets: [
        "CouchTidy"
    ])
], dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0")
], targets: [
    .target(name: "CouchData", dependencies: []),
    .target(name: "CouchTidy", dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        "CouchData"
    ]),
    .testTarget(name: "CouchDataTests", dependencies: [
        "CouchData"
    ])
])
