//
//  NearbyLocationResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import Foundation

// MARK: - NearbyLocationResponse
struct NearbyLocationResponse: Codable {
    let data: [NearbyLocation]
}

// MARK: - NearbyLocation
struct NearbyLocation: Codable {
    let locationID, name: String

    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
    }
}
