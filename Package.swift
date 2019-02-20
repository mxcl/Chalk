// swift-tools-version:5.0
import PackageDescription

let pkg = Package(
    name: "Chalk",
    products: [
        .library(name: "Chalk", targets: ["Chalk"]),
    ],
    targets: [
        .target(name: "Chalk", path: ".", sources: ["Chalk.swift"]),
    ],
    swiftLanguageVersions: [.v5]
)
