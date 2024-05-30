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
    let api_key: String = "5BA15C3888B94DB5BE9A756EB8675D38"
}
