//
//  AlertModifier.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
    @Binding var showAlert: Bool
    var error: Error?

    public func body(content: Content) -> some View {
        content
            .alert("", isPresented: $showAlert) {
                Button("Close", role: .cancel) {}
            } message: {
                Text(error?.localizedDescription ?? "")
            }
    }
}

public extension View {
    func showAlert(_ showAlert: Binding<Bool>, error: Error?) -> some View {
        modifier(AlertModifier(showAlert: showAlert, error: error))
    }
}

#Preview("General Error") {
    Text("Error View")
        .showAlert(.constant(true), error: NSError(domain: "Test", code: 0, userInfo: nil))
}

#Preview("URL Error") {
    Text("Error View")
        .showAlert(.constant(true), error: URLError(.badServerResponse))
}
