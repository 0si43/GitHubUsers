//
//  WebView.swift
//  GitHubUsers
//
//  Created by Nakajima on 2025/06/07.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public let urlString: String

    public init(urlString: String) {
        self.urlString = urlString
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
