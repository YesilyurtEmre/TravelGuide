//
//  TravelGuideTabView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct TravelGuideTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            CoreMLView()
                .tabItem {
                    Image(systemName: "camera.on.rectangle")
                    Text("CoreML")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(.appColor)
    }
}

#Preview {
    TravelGuideTabView()
}
