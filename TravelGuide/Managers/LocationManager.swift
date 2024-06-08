//
//  LocationManager.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI
import CoreLocation

final class LocationPermissionViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published
    var shouldNavigateToTravelGuide = false
    @Published
    var shouldShowPermissionAlert = false
    @Published
    var userCity: String? = "İstanbul"
    
    private var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        checkCurrentAuthorizationStatus()
    }
    
    func requestLocationPermission() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    switch self.locationManager.authorizationStatus {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()
                    case .restricted, .denied:
                        self.shouldShowPermissionAlert = true
                        self.setDefaultCity()
                    case .authorizedAlways, .authorizedWhenInUse:
                        self.locationManager.requestLocation()
                    @unknown default:
                        break
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.shouldShowPermissionAlert = true
                    self.setDefaultCity()
                }
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.requestLocation()
            case .restricted, .denied:
                self.shouldShowPermissionAlert = true
                self.setDefaultCity()
            case .notDetermined:
                break
            @unknown default:
                break
            }
        }
    }
    
    func checkCurrentAuthorizationStatus() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    switch self.locationManager.authorizationStatus {
                    case .authorizedAlways, .authorizedWhenInUse:
                        self.shouldNavigateToTravelGuide = true
                    case .notDetermined, .restricted, .denied:
                        self.shouldShowPermissionAlert = true
                    @unknown default:
                        break
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.shouldShowPermissionAlert = true
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            convertCoordinateToCityName(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { city in
                DispatchQueue.main.async {
                    self.userCity = city
                    AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.USER_CITY, value: city ?? "İstanbul")
                    AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.IS_GET_LOCATION_PERMISSION, value: true)
                    self.shouldNavigateToTravelGuide = true
                }
            }
        }
    }
    
    private func convertCoordinateToCityName(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let  placemark = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            if let error = error {
                print("Reverse geocoding error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            let city = placemark.administrativeArea ?? placemark.locality
            
            completion(city)
        }
    }
    
    private func setDefaultCity() {
        DispatchQueue.main.async {
            self.userCity = "İstanbul"
            AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.USER_CITY, value: "İstanbul")
            self.shouldNavigateToTravelGuide = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        setDefaultCity()
    }
}
