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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "advent2019",
            dependencies: ["Advent2019Kit"]),
        .target(
            name: "Advent2019Kit",
            dependencies: ["AdventLib"]),
        .testTarget(
            name: "Advent2019KitTests",
            dependencies: ["Advent2019Kit"]),
    ]
)
