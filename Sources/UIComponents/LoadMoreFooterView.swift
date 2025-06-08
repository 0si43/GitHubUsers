//
//  SwiftUIView.swift
//  GitHubUsersFeature
//
//  Created by Nakajima on 2025/06/08.
//

import SwiftUI

struct LoadMoreFooterView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

#Preview {
    LoadMoreFooterView()
}
