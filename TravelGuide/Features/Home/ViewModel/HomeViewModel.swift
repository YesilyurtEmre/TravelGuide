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
        
        locationPermissionViewModel.$userCity
            .dropFirst()
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
            async let fetchedLocationDetail = LocationService().fetchLocationDetails(locationId: locationId)
            async let fetchedLocationPhotos = LocationService().fetcLocationPhotos(locationId: locationId)
            
            let (locationDetail, locationPhotos) = try await (fetchedLocationDetail, fetchedLocationPhotos)
            
            self.locationDetail = locationDetail
            self.locationPhotos = locationPhotos
            
            let nearbyLocationsResponse: NearbyLocationResponse = try await LocationService().fetcNearbyLocation(lat: locationDetail.latitude, long: locationDetail.longitude)
            
            var tempNearbyLocationDetails: [NearbyLocationDetail] = []
            
            for nearbyLocation in nearbyLocationsResponse.data {
                do {
                    async let fetchedDetail = LocationService().fetchLocationDetails(locationId: nearbyLocation.locationID)
                    async let fetchedPhotos = LocationService().fetcLocationPhotos(locationId: nearbyLocation.locationID)
                    
                    let (details, photos) = try await (fetchedDetail, fetchedPhotos)
                    
                    print("Fetched details for location \(nearbyLocation.locationID): \(details)")
                    print("Fetched photos for location \(nearbyLocation.locationID): \(photos)")
                    
                    let nearbyLocationDetail = NearbyLocationDetail(details: details, photos: photos)
                    tempNearbyLocationDetails.append(nearbyLocationDetail)
                    
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
            isLoading = false
            
        } catch APIError.invalidURL {
            alertItem = AlertContext.invalidURL
            isLoading = false
        } catch APIError.invalidResponse {
            alertItem = AlertContext.invalidResponse
            isLoading = false
        } catch APIError.invalidData {
            alertItem = AlertContext.invalidData
            isLoading = false
        } catch {
            alertItem = AlertContext.unableToComplete
            isLoading = false
        }
    }
}
