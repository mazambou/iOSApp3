//
//  ArtworkResponse.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import Foundation

struct ArtworkResponse: Codable {
    let id: Int
    let title: String
    let creationDate: String?
    let creators: [CreatorResponse]?
    let images: ImageResponse?
    let description: String?
    let tombstone: String?
    let technique: String?
    let culture: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case creationDate = "creation_date"
        case creators
        case images
        case description
        case tombstone
        case technique
        case culture
    }

    var artwork: Artwork {
        // Convert the API response into the simpler model used by the views.
        Artwork(
            id: id,
            title: title,
            artist: creators?.first?.description ?? "Unknown artist",
            dateDisplay: creationDate ?? "Date unknown",
            imageURLString: images?.web?.url,
            largeImageURLString: images?.print?.url ?? images?.web?.url,
            thumbnailAltText: title,
            description: description?.removingHTMLTags ?? tombstone?.removingHTMLTags ?? "No description available.",
            medium: technique ?? "Medium unknown",
            placeOfOrigin: culture?.joined(separator: ", ") ?? "Origin unknown"
        )
    }
}

struct CreatorResponse: Codable {
    let description: String?
}

struct ImageResponse: Codable {
    let web: ImageInfoResponse?
    let print: ImageInfoResponse?
}

struct ImageInfoResponse: Codable {
    let url: String?
}

private extension String {
    var removingHTMLTags: String {
        replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
        .replacingOccurrences(of: "&amp;", with: "&")
        .replacingOccurrences(of: "&quot;", with: "\"")
        .replacingOccurrences(of: "&#39;", with: "'")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
