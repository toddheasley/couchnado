// swift-tools-version:6.0

import PackageDescription

let package: Package = Package(name: "couchdata", platforms: [
        .tvOS(.v17),
        .macOS(.v14),
        .visionOS(.v1),
        .iOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(name: "CouchData", targets: [
            "CouchData"
        ]),
        .library(name: "HyperCouch", targets: [
            "HyperCouch"
        ])
    ],
    targets: [
        .target(name: "CouchData", dependencies: []),
        .testTarget(name: "CouchDataTests", dependencies: [
            "CouchData"
        ]),
        .target(name: "HyperCouch", dependencies: [
            "CouchData"
        ], resources: [
            .process("Resources")
        ]),
        .testTarget(name: "HyperCouchTests", dependencies: [
            "HyperCouch",
            "CouchData"
        ])
    ])
