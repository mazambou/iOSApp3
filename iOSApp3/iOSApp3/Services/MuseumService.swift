//
//  MuseumService.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-21.
//

import Foundation

enum MuseumServiceError: LocalizedError {
    case invalidURL
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The search URL could not be created."
        case .invalidResponse:
            return "The museum API returned an invalid response."
        }
    }
}

final class MuseumService {
    func searchArtworks(query: String) async throws -> [Artwork] {
        let cleanedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedQuery.isEmpty else { return [] }

        var components = URLComponents(string: "\(Constants.apiBaseURL)/artworks/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: cleanedQuery),
            URLQueryItem(name: "size", value: "25"),
            URLQueryItem(name: "fields", value: "id,title,artist_title,date_display,image_id,thumbnail,description,medium_display,place_of_origin")
        ]

        guard let url = components?.url else {
            throw MuseumServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw MuseumServiceError.invalidResponse
        }

        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
        return searchResponse.data.map(\.artwork)
    }
}
