  // swift-tools-version:5.9

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
  name: "GitHubUsersFeature",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(name: "GitHubUsersFeature", targets: ["GitHubUsersFeature"]),
    .library(name: "UIComponents", targets: ["UIComponents"]),
  ],
  targets: [
    .target(
      name: "GitHubUsersFeature",
      dependencies: [
        "API",
        "Models",
        "UIComponents",
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
    ),
])
