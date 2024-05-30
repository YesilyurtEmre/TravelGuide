//
//  APIError.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

enum APIError: String, Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
