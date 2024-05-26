//
//  SplashView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI
import CoreLocation

struct SplashView: View {
    
    @ObservedObject
    private var navigation = Navigation()
    @ObservedObject
    private var locationViewModel = LocationPermissionViewModel()
    
    var body: some View {
        ZStack {
            Color.appColor
                .ignoresSafeArea()
            
            VStack(spacing: 100) {
                Spacer()
                Image("Onboarding1")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(10)
                Text("Travel with the help of the AI")
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
        }
        .onAppear {
             DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                 if AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.IS_SHOW_ONBOARDING) ?? false {
                     locationViewModel.checkCurrentAuthorizationStatus()
                     if locationViewModel.shouldNavigateToTravelGuide {
                         navigation.present(.page) {
                             TravelGuideTabView()
                         }
                     } else {
                         navigation.present(.page) {
                             LocationPermissionView()
                         }
                     }
                 } else {
                     navigation.present(.page) {
                         OnboardingView()
                     }
                 }
             }
         }
        .uses(navigation)
    }
}

#Preview {
    SplashView()
}
