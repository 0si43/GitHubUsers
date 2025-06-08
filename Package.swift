  // swift-tools-version:5.9

import Foundation
import PackageDescription

// MARK: - shared
var package = Package(
  name: "GitHubUsersAppFeature",
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
        "API",
        "Models",
        "UIComponents",
        "GitHubUsers",
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
    .target(
      name: "GitHubUsers"
    ),
    .testTarget(
      name: "GitHubUsersTests",
      dependencies: [
        "GitHubUsers"
      ]
    ),
])
