//
//  CameraOverlayView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI

struct CameraOverlayView: View {
    let label: String

    var body: some View {
        VStack(spacing: 10) {
            Text(label)
                .foregroundColor(.white)
                .font(.headline)
            Button {
                print("change card button tapped")
            } label: {
                Text("Search")
                    .customFont(.regular, size: 12)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}
