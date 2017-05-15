import PackageDescription

let package = Package(
    name: "SwiftMetric",
    targets: [
        Target(name: "swiftmetric", dependencies: ["SwiftMetricFramework"]),
        Target(name: "SwiftMetricFramework")
    ],
    dependencies: [
        .Package(
            url: "https://github.com/jpsim/SourceKitten.git",
            majorVersion: 0
        ),
        .Package(
            url: "https://github.com/davecom/SwiftGraph",
            majorVersion: 1
        ),
        .Package(
            url: "https://github.com/Carthage/Commandant.git",
            majorVersion: 0
        ),
        .Package(
            url: "https://github.com/johnsundell/files.git",
            majorVersion: 1
        )
    ]
 )
