// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "Aleo",
	products: [
		.library(
			name: "Aleo",
			targets: ["Aleo"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "Aleo",
			dependencies: ["RustXcframework"]),
        .testTarget(
            name: "AleoTests",
            dependencies: ["Aleo", "RustXcframework"])
	]
)
	
