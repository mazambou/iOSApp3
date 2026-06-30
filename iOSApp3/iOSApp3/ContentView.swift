//
//  ContentView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-19.
//

import SwiftUI

struct ContentView: View {
    // Favorites are stored locally so they stay available after the app closes.
    @AppStorage("favoriteArtworks") private var favoriteArtworksData = Data()
    @State private var favorites: [Artwork] = []

    var body: some View {
        TabView {
            WelcomeView(favoritesCount: favorites.count)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            HomeView(favorites: $favorites)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoritesView(favorites: $favorites)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .badge(favorites.count)
        }
        .onAppear(perform: loadFavorites)
        .onChange(of: favorites) { _, updatedFavorites in
            saveFavorites(updatedFavorites)
        }
    }

    private func loadFavorites() {
        guard !favoriteArtworksData.isEmpty else { return }

        do {
            favorites = try JSONDecoder().decode([Artwork].self, from: favoriteArtworksData)
        } catch {
            favorites = []
        }
    }

    private func saveFavorites(_ updatedFavorites: [Artwork]) {
        do {
            favoriteArtworksData = try JSONEncoder().encode(updatedFavorites)
        } catch {
            favoriteArtworksData = Data()
        }
    }
}

#Preview {
    ContentView()
}
