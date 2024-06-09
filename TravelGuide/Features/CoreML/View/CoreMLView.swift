//
//  CoreMLView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct CoreMLView: View {
    var body: some View {
        TabView {
//            CameraLiveView(viewModel: CameraLiveViewModel())
//                .tabItem {
//                    Image(systemName: "camera")
//                    Text("Camera")
//                }
            GalleryView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Gallery")
                }
        }
    }
}

#Preview {
    CoreMLView()
}
