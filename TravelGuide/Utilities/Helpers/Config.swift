//
//  Config.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

final class Config {
    static let shared = Config()
    
    private init(){}
    
    let scheme: String = "https"
    let host: String = "api.content.tripadvisor.com"
    let path: String = "/api/v1/location"
    let api_key: String = "5E211A7F00A64E8FA394F955BE12360F"
    
    let places: [String] = ["Ankara", "İstanbul", "Elâzığ", "Antalya", "Bursa", "İzmir", "Çanakkale", "Trabzon", "Mardin", "Gaziantep"]
    
    let placesIds: [String: String] = [
        "Ankara": "298656",
        "İstanbul": "293974",
        "Elâzığ": "672950",
        "Antalya": "297962",
        "Bursa": "297977",
        "İzmir": "298006",
        "Çanakkale": "297979",
        "Trabzon": "298039",
        "Mardin": "672951",
        "Gaziantep": "297998"
    ]
}
