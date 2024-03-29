// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShopScreen",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ShopScreen",
            targets: ["ShopScreen"])
    ],
    dependencies: [
            .package(name: "NetworkManager", path: "/SPM/NetworkManager"),
            .package(name: "Const", path: "/SPM/Const")
        ],
    targets: [
        .target(
            name: "ShopScreen",
            dependencies: ["NetworkManager", "Const"])
    ]
)
