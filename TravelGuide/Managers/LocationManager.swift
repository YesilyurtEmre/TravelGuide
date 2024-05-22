//
//  LocationManager.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    @Published var userCity: String?
   

    override private init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            convertCoordinateToCityName(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { city in
                self.userCity = city
                //UserDefaults.standard.set(city, forKey: "userCity")
                AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.USER_CITY, value: city ?? "")
                AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.IS_GET_LOCATION_PERMISSION, value: true)
                
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
    
    private func convertCoordinateToCityName(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            guard let placemark = placemarks?.first, error == nil else {
//                completion(nil)
//                return
//            }
            if let error = error {
                print("Reverse geooding error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                      print("No placemarks found")
                      completion(nil)
                      return
                  }
            
            completion(placemark.locality)
        }
    }
}
