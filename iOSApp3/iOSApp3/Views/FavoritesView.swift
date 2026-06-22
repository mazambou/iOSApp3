//
//  FavoritesView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var favorites: [Artwork]

    var body: some View {
        NavigationStack {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text("Save artworks from the detail screen to review them here.")
                    )
                } else {
                    List(favorites) { artwork in
                        NavigationLink {
                            ArtworkDetailView(
                                artwork: artwork,
                                isFavorite: true,
                                onToggleFavorite: { removeFavorite(artwork) }
                            )
                        } label: {
                            ArtworkRowView(artwork: artwork)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }

    private func removeFavorite(_ artwork: Artwork) {
        favorites.removeAll { $0.id == artwork.id }
    }
}
