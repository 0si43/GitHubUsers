//
//  LoadingViewModifier.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

import SwiftUI

public struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    var message: String?

    public func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    if let message {
                        ProgressView(message)
                            .progressViewStyle(.default)
                    } else {
                        ProgressView()
                            .progressViewStyle(.default)
                    }
                }
            }
    }
}

private struct CommonProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .padding(16)
            if let label = configuration.label {
                label
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .accessibilityIdentifier(#function)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primary.opacity(0.6))
        }
    }
}

private extension ProgressViewStyle where Self == CommonProgressViewStyle {
    static var `default`: CommonProgressViewStyle {
        .init()
    }
}

public extension View {
    func loading(_ isLoading: Binding<Bool>, message: String? = nil) -> some View {
        modifier(
            LoadingViewModifier(isLoading: isLoading, message: message)
        )
    }
}

#Preview("文字なし") {
    Text("Progress View")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .loading(.constant(true))
}

#Preview("文字あり") {
    Text("Progress View")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .loading(.constant(true), message: "AAAAAAAA")
}
