//
//  HomeView.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import SwiftUI

struct HomeView: View {
    @Binding var favorites: [Artwork]
    @State private var searchText = Constants.defaultSearchTerm
    @State private var artworks: [Artwork] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let museumService = MuseumService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(Constants.museumName)
                        .font(.title2)
                        .fontWeight(.semibold)

                    SearchBarView(searchText: $searchText) {
                        Task { await search() }
                    }

                    Button {
                        Task { await search() }
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)
                }
                .padding()

                if isLoading {
                    LoadingView()
                } else if let errorMessage {
                    ContentUnavailableView(
                        "Search Failed",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
                } else if artworks.isEmpty {
                    ContentUnavailableView(
                        "Search the Collection",
                        systemImage: "building.columns",
                        description: Text("Find artworks from the Art Institute of Chicago collection.")
                    )
                } else {
                    ResultsView(artworks: artworks, favorites: $favorites)
                }
            }
            .navigationTitle("Collection Search")
            .task {
                if artworks.isEmpty {
                    await search()
                }
            }
        }
    }

    private func search() async {
        isLoading = true
        errorMessage = nil

        do {
            artworks = try await museumService.searchArtworks(query: searchText)
        } catch {
            artworks = []
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
