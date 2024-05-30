//
//  LocationDetailResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

struct LocationDetailResponse: Codable {
    let locationID, name, description: String
    let webURL: String
    let addressObj: AddressObj
    let ancestors: [Ancestor]
    let latitude, longitude, timezone: String
    let seeAllPhotos: String
    let category: Category
    let subcategory: [Category]
    let neighborhoodInfo: [NeighborhoodObj]
    let awards: [AwardsObj]
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name, description
        case webURL = "web_url"
        case addressObj = "address_obj"
        case ancestors, latitude, longitude, timezone
        case seeAllPhotos = "see_all_photos"
        case category, subcategory
        case neighborhoodInfo = "neighborhood_info"
        case awards
    }
}

// MARK: - Ancestor
struct Ancestor: Codable {
    let level, name, locationID: String
    
    enum CodingKeys: String, CodingKey {
        case level, name
        case locationID = "location_id"
    }
}

// MARK: - Category
struct Category: Codable {
    let name, localizedName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

// MARK: - AwardsObj
struct AwardsObj: Codable {
    let awardType, year, displayName: String
    let categories: [String]
    let images: [ImageObj]
    
    enum CodingKeys: String, CodingKey {
        case awardType = "award_type"
        case year
        case displayName = "display_name"
        case categories
        case images
    }
}

// MARK: - NeighborhoodObj
struct NeighborhoodObj: Codable {
    let locationID, name: String
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
    }
}

// MARK: - ImageObj
struct ImageObj: Codable {
    let tiny, small, large: String
}
