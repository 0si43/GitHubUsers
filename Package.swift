// swift-tools-version:6.0

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
  name: "AppFeature",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(name: "GitHubUsersFeature", targets: ["GitHubUsersFeature"]),
    .library(name: "UIComponents", targets: ["UIComponents"])
  ],
  targets: [
    .target(
      name: "GitHubUsersFeature",
      dependencies: [
        "API",
        "Models",
        "UIComponents"
      ]
    ),
    .testTarget(
      name: "GitHubUsersFeatureTests",
      dependencies: [
        "GitHubUsersFeature"
      ]
    ),
    .target(
      name: "API"
    ),
    .target(
      name: "Models"
    ),
    .target(
      name: "UIComponents"
    )
  ])
