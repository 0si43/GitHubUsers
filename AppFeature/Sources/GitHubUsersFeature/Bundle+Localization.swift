//
//  Bundle+Localization.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

import Foundation

extension Bundle {
    static var current: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle.main
        #endif
    }
}

extension String {
    public var localized: String {
        String(localized: String.LocalizationValue(self), bundle: Bundle.current)
    }
}
