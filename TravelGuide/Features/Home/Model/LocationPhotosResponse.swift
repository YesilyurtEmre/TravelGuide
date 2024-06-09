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
    let images: Images
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, medium, large: Large
    let original: Large?
    
}

// MARK: - Large
struct Large: Codable {
    let height, width: Int
    let url: String
}
