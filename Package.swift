  // swift-tools-version:5.9

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
  name: "AppFeature",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        "GitHubUsers",
      ]
    ),
    .target(
      name: "GitHubUsers",
      dependencies: [
        "API",
        "Models",
        "UIComponents",
      ]
    ),
    .testTarget(
      name: "GitHubUsersTests",
      dependencies: [
        "GitHubUsers"
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
