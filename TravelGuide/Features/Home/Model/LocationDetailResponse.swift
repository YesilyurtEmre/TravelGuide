//
//  LocationDetailResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

struct LocationDetailResponse: Codable {
    let locationID, name: String
    let description: String?
    let latitude, longitude: String
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
        case description
        case latitude, longitude
    }
}
