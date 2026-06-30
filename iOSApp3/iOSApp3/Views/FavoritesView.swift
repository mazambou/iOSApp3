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
                        description: Text("Save artworks from the detail screen or result list to review them here.")
                    )
                } else {
                    List {
                        Section("Saved Artworks") {
                            ForEach(favorites) { artwork in
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
                            .onDelete(perform: removeFavorites)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                if !favorites.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear") {
                            favorites.removeAll()
                        }
                    }
                }
            }
        }
    }

    private func removeFavorite(_ artwork: Artwork) {
        favorites.removeAll { $0.id == artwork.id }
    }

    private func removeFavorites(at offsets: IndexSet) {
        // Supports the standard swipe-to-delete gesture in the favorites list.
        favorites.remove(atOffsets: offsets)
    }
}
