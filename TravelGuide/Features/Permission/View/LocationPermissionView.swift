//
//  LocationPermissionView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct LocationPermissionView: View {
    
    @ObservedObject
    private var viewModel = LocationPermissionViewModel()
    @ObservedObject
    private var navigation = Navigation()
    
    var body: some View {
        VStack {
            Text("Give Location Permission")
                .font(.title)
                .padding()
            
            Button(action: {
                viewModel.requestLocationPermission()
            }) {
                Text("Allow Location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onChange(of: viewModel.shouldNavigateToTravelGuide) { shouldNavigate in
            if shouldNavigate {
                navigation
                    .present(.page) {
                        TravelGuideTabView()
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
