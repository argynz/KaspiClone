// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TransferScreen",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "TransferScreen",
            targets: ["TransferScreen"])
    ],
    dependencies: [
        .package(name: "Const", path: "/SPM/Const")
    ],
    targets: [
        .target(
            name: "TransferScreen",
            dependencies: [
                "Const"
            ],
            resources: [
                    .process("models/DataModelCompiled.momd")
            ]
        )
    ]
)
