//
//  HomeViewModel.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI
import Combine

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
    var nearbyLocationDetails: [NearbyLocationDetail] = []
    @Published
    var selectedNearbyLocation: NearbyLocationDetail?
    @Published
    var isShowingDetail = false
    @Published
    var selectedLocation: NearbyLocationDetail?
    @Published
    var isCityChange = false
    
    var locationId = "298656"
    
    @ObservedObject
    private var locationPermissionViewModel = LocationPermissionViewModel()
    
    
    init() {
        locationId = Config.shared.placesIds.first(where: { $0.key == locationPermissionViewModel.userCity })?.value ?? ""
        Task {
            await searchLocation(locationId: locationId)
        }
        
        // Listen to changes in userCity and update locationId accordingly
        locationPermissionViewModel.$userCity
            .dropFirst() // Skip the initial value
            .sink { [weak self] newCity in
                guard let self = self, let newCity = newCity else { return }
                self.locationId = Config.shared.placesIds[newCity] ?? ""
                Task {
                    await self.searchLocation(locationId: self.locationId)
                }
            }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func searchLocation(locationId: String) async {
        isLoading = true
        do {
            locationDetail = try await LocationService().fetchLocationDetails(locationId: locationId)
            locationPhotos = try await LocationService().fetcLocationPhotos(locationId: locationId)
            
            if let locationDetail = locationDetail {
                let nearbyLocationsResponse: NearbyLocationResponse = try await LocationService().fetcNearbyLocation(lat: locationDetail.latitude, long: locationDetail.longitude)
                
                var tempNearbyLocationDetails: [NearbyLocationDetail] = []
                
                for nearbyLocation in nearbyLocationsResponse.data {
                    do {
                        let fetchedDetail = try await LocationService().fetchLocationDetails(locationId: nearbyLocation.locationID)
                        print("Fetched details for location \(nearbyLocation.locationID): \(fetchedDetail)")
                        let fetchedPhotos = try await LocationService().fetcLocationPhotos(locationId: nearbyLocation.locationID)
                        print("Fetched photos for location \(nearbyLocation.locationID): \(fetchedPhotos)")
                        
                        let nearbyLocationDetail = NearbyLocationDetail(details: fetchedDetail, photos: fetchedPhotos)
                        tempNearbyLocationDetails.append(nearbyLocationDetail)
                        
                        // İstekler arasında gecikme ekleyin
                        try await Task.sleep(nanoseconds: 200_000_000)
                    } catch APIError.invalidURL {
                        print("Invalid URL for location: \(nearbyLocation.locationID)")
                    } catch APIError.invalidResponse {
                        print("Invalid response for location \(nearbyLocation.locationID).")
                    } catch APIError.invalidData {
                        print("Invalid data for location \(nearbyLocation.locationID).")
                    } catch {
                        print("Unknown error for location: \(nearbyLocation.locationID), error: \(error)")
                    }
                }
                nearbyLocationDetails = tempNearbyLocationDetails
                
            } else {
                alertItem = AlertContext.invalidData
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
