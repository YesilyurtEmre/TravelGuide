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
    let api_key: String = ""
    
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
    
    let coreMLIds: [String: String] = [
        "OperaHouse": "257278",
        "PisaTower": "195452",
        "Eiffel": "188151",
        "Pyramids": "317746",
        "Colosseum": "192285"
    ]
}
