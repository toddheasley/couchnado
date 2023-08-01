// swift-tools-version:5.9

import PackageDescription

let package: Package = Package(name: "couchdata", platforms: [
        .tvOS(.v17),
        .visionOS(.v1),
        .iOS(.v17),
        .macOS(.v14)
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
        ], resources: [
            .process("Resources")
        ]),
        .target(name: "HyperCouch", dependencies: [
            "CouchData"
        ], resources: [
            .process("Resources")
        ]),
        .testTarget(name: "HyperCouchTests", dependencies: [
            "CouchData",
            "HyperCouch"
        ], resources: [
            .process("Resources")
        ])
    ])
