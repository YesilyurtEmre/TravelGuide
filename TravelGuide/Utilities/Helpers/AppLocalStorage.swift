//
//  AppLocalStorage.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import Foundation
import CoreLocation

final class AppLocalStorage {
    enum Key: String, CaseIterable {
        case name, avatarData, userLocation
        func make(for userID: String) -> String {
            return self.rawValue + "_" + userID
        }
    }
    
    static let shared = AppLocalStorage()
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveValue(forKey key: String, value: Any) {
        userDefaults.set(value, forKey: key)
    }
    
    func readValue<T>(forKey key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }
    
    // Function to save user's location
    func saveUserLocation(_ location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let locationDict: [String: Double] = ["latitude": latitude, "longitude": longitude]
        saveValue(forKey: Key.userLocation.rawValue, value: locationDict)
    }
    
    // Function to retrieve user's location
    func getUserLocation() -> CLLocation? {
        guard let locationDict: [String: Double] = readValue(forKey: Key.userLocation.rawValue),
              let latitude = locationDict["latitude"],
              let longitude = locationDict["longitude"] else {
            return nil
        }
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}

