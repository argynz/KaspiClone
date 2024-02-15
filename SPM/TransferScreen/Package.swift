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
            targets: ["TransferScreen"]),
    ],
    targets: [
        .target(
            name: "TransferScreen"),
    ]
)
