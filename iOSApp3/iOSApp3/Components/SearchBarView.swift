//
//  SearchBarView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    let onSearch: () -> Void
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search artworks", text: $searchText)
                .textInputAutocapitalization(.words)
                .submitLabel(.search)
                .onSubmit(onSearch)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

