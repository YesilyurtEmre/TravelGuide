//
//  LocationPhotosResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

// MARK: - LocationPhotosResponse
struct LocationPhotosResponse: Codable {
    let data: [LocationPhoto]
}

// MARK: - Datum
struct LocationPhoto: Codable {
    let id: Int
    let isBlessed: Bool
    let caption, publishedDate: String
    let images: Images
    let album: String
    let source: Source
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case isBlessed = "is_blessed"
        case caption
        case publishedDate = "published_date"
        case images, album, source, user
    }
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, medium, large: Large
    let original: Large
}

// MARK: - Large
struct Large: Codable {
    let height, width: Int
    let url: String
}

// MARK: - Source
struct Source: Codable {
    let name, localizedName: String

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

// MARK: - User
struct User: Codable {
    let username: String
}
