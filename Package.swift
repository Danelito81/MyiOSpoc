// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TryggSamtalApp",
    platforms: [ .iOS(.v15) ],
    products: [
        .library(name: "TryggSamtalApp", targets: ["TryggSamtalApp"])
    ],
    targets: [
        .target(
            name: "TryggSamtalApp",
            dependencies: [],
            path: "."
        )
    ]
)
