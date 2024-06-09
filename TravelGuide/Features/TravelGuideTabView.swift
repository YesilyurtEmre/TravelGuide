//
//  TravelGuideTabView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct TravelGuideTabView: View {
    
    
    @State private var tabSelection = 0
    @StateObject var sharedData = SharedData()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(sharedData)
                .tag(0)
            
            
            CoreMLView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "camera.on.rectangle")
                    Text("CoreML")
                }
                .environmentObject(sharedData)
                .tag(1)
            
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
                .tag(2)
            
        }
        .accentColor(.appColor)
    }
}
