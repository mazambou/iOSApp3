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
    let artistTitle: String?
    let dateDisplay: String?
    let imageID: String?
    let thumbnail: Thumbnail?
    let description: String?
    let mediumDisplay: String?
    let placeOfOrigin: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artistTitle = "artist_title"
        case dateDisplay = "date_display"
        case imageID = "image_id"
        case thumbnail
        case description
        case mediumDisplay = "medium_display"
        case placeOfOrigin = "place_of_origin"
    }

    var artwork: Artwork {
        Artwork(
            id: id,
            title: title,
            artist: artistTitle ?? "Unknown artist",
            dateDisplay: dateDisplay ?? "Date unknown",
            imageID: imageID,
            thumbnailAltText: thumbnail?.altText,
            thumbnailDataURL: thumbnail?.lqip,
            description: description?.removingHTMLTags ?? "No description available.",
            medium: mediumDisplay ?? "Medium unknown",
            placeOfOrigin: placeOfOrigin ?? "Origin unknown"
        )
    }
}

struct Thumbnail: Codable {
    let lqip: String?
    let altText: String?

    enum CodingKeys: String, CodingKey {
        case lqip
        case altText = "alt_text"
    }
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
