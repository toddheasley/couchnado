// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "couch-data", platforms: [
    .macOS(.v10_16),
    .iOS(.v14),
    .tvOS(.v14)
], products: [
    .library(name: "CouchData", targets: [
        "CouchData"
    ])
], targets: [
    .target(name: "CouchData", dependencies: []),
    .testTarget(name: "CouchDataTests", dependencies: [
        "CouchData"
    ])
])
