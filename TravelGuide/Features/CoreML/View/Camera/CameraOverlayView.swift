//
//  CameraOverlayView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI

struct CameraOverlayView: View {
    let label: String
    let confidence: String

    var body: some View {
        VStack(spacing: 10) {
            Text(label)
                .foregroundColor(.white)
                .font(.headline)
            Text("Güvenilirlik: \(confidence)")
                .foregroundColor(.white)
                .font(.subheadline)
        }
        .padding()
    }
}
