//
//  HomeViewModel.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published
    var locations: [Location] = []
    @Published
    var alertItem: AlertItem?
    @Published
    var isLoading = false
    @Published
    var locationDetail: LocationDetailResponse?
    @Published
    var locationPhotos: LocationPhotosResponse?
    @Published
    var locationReviews: LocationReviewsResponse?
    
    init() {
        Task {
            await searchLocation(city: AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY)!)
        }
    }
    
    func searchLocation(city: String) async {
        isLoading = true
        do {
            let fetchedLocations = try await LocationService().searchLocation(city: city)
            locations = fetchedLocations.data
            
            if let location = fetchedLocations.data.first(where: { $0.name == AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY)! }) {
                locationDetail = try await LocationService().fetchLocationDetails(locationId: location.locationID)
                locationPhotos = try await LocationService().fetcLocationPhotos(locationId: location.locationID)
                locationReviews = try await LocationService().fetcLocationReviews(locationId: location.locationID)
            }
            
        } catch APIError.invalidURL {
            alertItem = AlertContext.invalidURL
        } catch APIError.invalidResponse {
            alertItem = AlertContext.invalidResponse
        } catch APIError.invalidData {
            alertItem = AlertContext.invalidData
        } catch {
            alertItem = AlertContext.unableToComplete
        }
        isLoading = false
    }
}
