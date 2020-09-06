// swift-tools-version:5.3
import PackageDescription

let package = Package(name: "couch-data", platforms: [
    .macOS(.v11),
    .iOS(.v14),
    .watchOS(.v7),
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
