//
//  CoreMLView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct CoreMLView: View {
    @EnvironmentObject var sharedData: SharedData
    @Binding var tabSelection: Int
    
    var body: some View {
        TabView {
            CameraLiveView(viewModel: CameraLiveViewModel(), tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
            GalleryView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Gallery")
                }
        }
    }
}
