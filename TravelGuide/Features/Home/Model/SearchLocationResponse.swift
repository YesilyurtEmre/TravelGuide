//
//  SearchLocationResponse.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

struct SearchLocationResponse: Codable {
    let data: [Location]
}

struct Location: Codable, Identifiable {
    var id: UUID = UUID()
    let locationID: String
    let name: String
    let distance: String?
    let bearing: String?
    let addressObj: AddressObj
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
        case distance
        case bearing
        case addressObj = "address_obj"
    }
}

struct AddressObj: Codable {
    let street1: String?
    let street2: String?
    let city: String?
    let state: String?
    let country: String?
    let postalcode: String?
    let addressString: String?
    
    enum CodingKeys: String, CodingKey {
        case street1
        case street2
        case city
        case state
        case country
        case postalcode
        case addressString = "address_string"
    }
}

struct MockData {
    static let sampleLocation = Location(
        locationID: "293974",
        name: "Istanbul",
        distance: nil,
        bearing: nil,
        addressObj: AddressObj(
            street1: nil,
            street2: nil,
            city: "İstanbul",
            state: nil,
            country: "Türkiye",
            postalcode: nil,
            addressString: "stanbul Turkiye"
        )
    )
    
    static let locations = [sampleLocation, sampleLocation, sampleLocation]
}
