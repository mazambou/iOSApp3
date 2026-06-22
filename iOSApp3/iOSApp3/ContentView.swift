//
//  ContentView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-19.
//

import SwiftUI

struct ContentView: View {
    @State private var favorites: [Artwork] = []

    var body: some View {
        TabView {
            HomeView(favorites: $favorites)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            FavoritesView(favorites: $favorites)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    ContentView()
}
