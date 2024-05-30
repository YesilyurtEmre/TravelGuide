//
//  APIRequest.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI

typealias CompletionHandler = (Data) -> Void
typealias FailureHandler = (APIError) -> Void

struct EmptyRequest: Encodable {}
struct EmptyResponse: Decodable {}

enum HTTPMethod: String {
    case get
}

final class APIRequest {
    static let shared = APIRequest()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}

    func call(
        scheme: String = Config.shared.scheme,
        host: String = Config.shared.host,
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> Data {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return data
    }
    
    func downloadImage(fromURLString urlString: String) async throws -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        self.cache.setObject(image, forKey: cacheKey)
        return image
    }
}
