// swift-tools-version:5.5

import PackageDescription

let package = Package(name: "couchdata", platforms: [
        .tvOS(.v15),
        .iOS(.v15),
        .watchOS(.v8),
        .macOS(.v12)
    ],
    products: [
        .library(name: "CouchData", targets: [
            "CouchData"
        ]),
    ],
    targets: [
        .target(name: "CouchData", dependencies: []),
        .testTarget(name: "CouchDataTests", dependencies: [
                "CouchData"
        ])
    ])
