// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent2019",
    products: [.executable(name: "advent2019", targets: ["advent2019"])],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../AdventLib")
    ],
    targets: [
         .target(
            name: "advent2019",
            dependencies: ["Advent2019Kit"]),
        .target(
            name: "Advent2019Kit",
            dependencies: ["AdventLib", "Intcode"]),
        .testTarget(
            name: "Advent2019KitTests",
            dependencies: ["Advent2019Kit"]),
        .target(
            name: "Intcode",
            dependencies: ["AdventLib"]),
        .testTarget(
            name: "IntcodeTests",
            dependencies: ["Intcode"])
    ]
)
