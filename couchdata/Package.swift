// swift-tools-version:5.5

import PackageDescription

let package = Package(name: "couchdata", platforms: [
        .tvOS(.v15),
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .library(name: "CouchData", targets: [
            "CouchData"
        ]),
        .library(name: "CouchSite", targets: [
            "CouchSite"
        ])
    ],
    targets: [
        .target(name: "CouchData", dependencies: [], resources: []),
        .testTarget(name: "CouchDataTests", dependencies: [
            "CouchData"
        ], resources: [
            .process("Resources")
        ]),
        .target(name: "CouchSite", dependencies: [
            "CouchData"
        ], resources: []),
        .testTarget(name: "CouchSiteTests", dependencies: [
            "CouchData",
            "CouchSite"
        ], resources: [
            .process("Resources")
        ])
    ])
