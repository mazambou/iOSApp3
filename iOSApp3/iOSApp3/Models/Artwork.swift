//
//  Artwork.swift
//  iOSApp3
//
//  Created by AZAMBOU Marcel on 2026-06-20.
//

import Foundation

struct Artwork: Identifiable, Codable, Equatable {
    let id: Int
    let title: String
    let artist: String
    let dateDisplay: String
    let imageURLString: String?
    let largeImageURLString: String?
    let thumbnailAltText: String?
    let description: String
    let medium: String
    let placeOfOrigin: String

    var imageURL: URL? {
        guard let imageURLString else { return nil }
        return URL(string: imageURLString)
    }

    var largeImageURL: URL? {
        guard let largeImageURLString else { return imageURL }
        return URL(string: largeImageURLString)
    }
}
