// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkManager",
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"])
    ],
    dependencies: [
            // List of dependencies
    ],
    targets: [
        .target(
            name: "NetworkManager")
    ]
)
