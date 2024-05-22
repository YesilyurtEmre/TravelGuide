//
//  LocationPermissionView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI
import CoreLocation


class LocationModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}


struct LocationPermissionView: View {
    @ObservedObject private var navigation = Navigation()
    @ObservedObject var model = LocationModel()
    @StateObject var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack {
            Image("main_background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Button {
                    navigation
                        .present(.page) {
                            HomeView()
                        }
                    locationManager.requestLocationAuthorization()
                   
//                    model.requestAuthorisation(always: true)
//                    if AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.IS_GET_LOCATION_PERMISSION) ?? false {
//                        navigation
//                            .present(.page) {
//                                HomeView()
//                            }
//                    }
                    
                } label: {
                    Text("Give Location Permission")
                }
                
            }
        }
        .uses(navigation)
        .navigationBarHidden(true)
        
    }
}

#Preview {
    LocationPermissionView()
}
