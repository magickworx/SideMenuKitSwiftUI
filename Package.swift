// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SideMenuKitSwiftUI",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "SideMenuKitSwiftUI",
            targets: ["SideMenuKitSwiftUI"]
        ),
    ],
    targets: [
        .target(
            name: "SideMenuKitSwiftUI"
        ),
    ]
)
