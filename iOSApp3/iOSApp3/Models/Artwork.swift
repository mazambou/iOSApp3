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
    let imageID: String?
    let thumbnailAltText: String?
    let thumbnailDataURL: String?
    let description: String
    let medium: String
    let placeOfOrigin: String

    var imageURL: URL? {
        guard let imageID else { return nil }
        return URL(string: "\(Constants.imageBaseURL)/\(imageID)/full/300,/0/default.jpg")
    }

    var largeImageURL: URL? {
        guard let imageID else { return nil }
        return URL(string: "\(Constants.imageBaseURL)/\(imageID)/full/843,/0/default.jpg")
    }

    var thumbnailImageData: Data? {
        guard let thumbnailDataURL,
              let base64Text = thumbnailDataURL.components(separatedBy: "base64,").last else {
            return nil
        }

        return Data(base64Encoded: base64Text)
    }
}
