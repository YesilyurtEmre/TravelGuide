//
//  LocationService.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import Foundation

struct LocationService {
    
    func searchLocation(city: String) async throws -> SearchLocationResponse {
        let searchLocationQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: Config.shared.api_key),
            URLQueryItem(name: "searchQuery", value: city),
            URLQueryItem(name: "language", value: "en")
        ]
        
        let data = try await APIRequest.shared.call(
            path: Config.shared.path + "/search",
            queryItems: searchLocationQueryItems
        )
        
        guard let response = try? JSONDecoder().decode(SearchLocationResponse.self, from: data) else {
            throw APIError.invalidResponse
        }
        
        return response
    }
    
    func fetchLocationDetails(locationId: String) async throws -> LocationDetailResponse {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: Config.shared.api_key),
            URLQueryItem(name: "locationId", value: locationId)
        ]
        
        let data = try await APIRequest.shared.call(
            path: Config.shared.path + "/\(locationId)/details",
            queryItems: queryItems
        )
        
        guard let response = try? JSONDecoder().decode(LocationDetailResponse.self, from: data) else {
            throw APIError.invalidResponse
        }
        
        return response
    }
    
    func fetcLocationPhotos(locationId: String) async throws -> LocationPhotosResponse {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: Config.shared.api_key),
            URLQueryItem(name: "locationId", value: locationId)
        ]
        
        let data = try await APIRequest.shared.call(
            path: Config.shared.path + "/\(locationId)/photos",
            queryItems: queryItems
        )
        
        guard let response = try? JSONDecoder().decode(LocationPhotosResponse.self, from: data) else {
            throw APIError.invalidResponse
        }
        
        return response
    }
    
    func fetcNearbyLocation(lat: String = "41.00986", long: String = "28.95707") async throws -> NearbyLocationResponse {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: Config.shared.api_key),
            URLQueryItem(name: "latLong", value: "\(lat),\(long)")
        ]
        
        let data = try await APIRequest.shared.call(
            path: Config.shared.path + "/nearby_search",
            queryItems: queryItems
        )
        
        guard let response = try? JSONDecoder().decode(NearbyLocationResponse.self, from: data) else {
            throw APIError.invalidResponse
        }
        
        return response
    }
}
