//
//  LocationReviewsResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

// MARK: - LocationReviewsResponse
struct LocationReviewsResponse: Codable {
    let data: [LocationReview]
}

// MARK: - Datum
struct LocationReview: Codable {
    let id: Int
    let lang: String
    let locationID: Int
    let publishedDate: Date
    let rating, helpfulVotes: Int
    let ratingImageURL: String
    let url: String
    let text, title, tripType, travelDate: String
    let user: ReviewUser
    let subratings: Subratings

    enum CodingKeys: String, CodingKey {
        case id, lang
        case locationID = "location_id"
        case publishedDate = "published_date"
        case rating
        case helpfulVotes = "helpful_votes"
        case ratingImageURL = "rating_image_url"
        case url, text, title
        case tripType = "trip_type"
        case travelDate = "travel_date"
        case user, subratings
    }
}

// MARK: - Subratings
struct Subratings: Codable {
}

// MARK: - User
struct ReviewUser: Codable {
    let username: String
    let userLocation: UserLocation
    let avatar: Avatar

    enum CodingKeys: String, CodingKey {
        case username
        case userLocation = "user_location"
        case avatar
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let thumbnail, small, medium, large: String
    let original: String
}

// MARK: - UserLocation
struct UserLocation: Codable {
    let id, name: String
}
