//
//  CameraOverlayView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI

struct CameraOverlayView: View {
    @EnvironmentObject var sharedData: SharedData
    @Binding var tabSelection: Int
    let label: String

    var body: some View {
        HStack(spacing: 10) {
            Text(label)
                .foregroundColor(.white)
                .font(.headline)
            Button {
                tabSelection = 0
                sharedData.textValue  = label
            } label: {
                Text("Search")
                    .customFont(.regular, size: 12)
                    .foregroundColor(.white)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .padding(.bottom, 40)
    }
}
