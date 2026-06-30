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
    @State private var lastSearchTerm = ""
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let museumService = MuseumService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchHeader

                if isLoading {
                    LoadingView()
                } else if let errorMessage {
                    errorView(message: errorMessage)
                } else if artworks.isEmpty {
                    emptyView
                } else {
                    ResultsView(artworks: artworks, favorites: $favorites)
                        .refreshable {
                            await search()
                        }
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

    private var searchHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Constants.museumName)
                .font(.title2)
                .fontWeight(.semibold)

            Text("Search public collection records, view artwork details, and save favorites.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

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

            if !lastSearchTerm.isEmpty && !artworks.isEmpty {
                Text("\(artworks.count) results for \"\(lastSearchTerm)\"")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
    }

    private var emptyView: some View {
        ContentUnavailableView(
            "Search the Collection",
            systemImage: "building.columns",
            description: Text("Try an artist, artwork title, object type, or historical period.")
        )
    }

    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label("Search Failed", systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                Task { await search() }
            }
            .buttonStyle(.borderedProminent)
        }
    }

    @MainActor
    private func search() async {
        // Keep UI state changes on the main actor while the service performs the API request.
        let cleanedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedSearchText.isEmpty else { return }

        isLoading = true
        errorMessage = nil

        do {
            artworks = try await museumService.searchArtworks(query: cleanedSearchText)
            lastSearchTerm = cleanedSearchText
        } catch {
            artworks = []
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
