// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileScreen",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ProfileScreen",
            targets: ["ProfileScreen"]),
    ],
    dependencies: [
        .package(name: "NetworkManager",path: "/SPM/NetworkManager"),
    ],
    targets: [
        .target(
            name: "ProfileScreen",
            dependencies: [
                "NetworkManager"
            ]),
    ]
)
