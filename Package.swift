// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TryggSamtalApp",
    platforms: [.iOS(.v15)],
    products: [
        .executable(name: "TryggSamtalApp", targets: ["TryggSamtalApp"])
    ],
    targets: [
        .executableTarget(
            name: "TryggSamtalApp",
            path: "Sources/TryggSamtalApp"
        )
    ]
)
