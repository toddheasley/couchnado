// swift-tools-version:6.0

import PackageDescription

let package: Package = Package(name: "CouchData", platforms: [
        .tvOS(.v18),
        .macOS(.v15),
        .visionOS(.v2),
        .iOS(.v18),
        .watchOS(.v11)
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
