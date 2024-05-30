//
//  CameraLiveView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI
import AVKit

struct CameraLiveView: View {
    @ObservedObject var viewModel: CameraLiveViewModel

    var body: some View {
        VStack {
            if let _ = viewModel.previewLayer {
                CameraPreview(previewLayer: $viewModel.previewLayer)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.8) // Kamera ekranın %80'ini kaplasın
            } else {
                Spacer()
                Text("Kamera yükleniyor...")
                    .foregroundColor(.white)
                    .transition(.scale)
                    .animation(.default)
            }
            CameraOverlayView(
                label: viewModel.label,
                confidence: viewModel.confidence
            )
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.1) // Textler ekranın %10'unda yer alsın

            Spacer()
        }
        .background(Color.black) // Arka plan rengini siyahtan griye değiştir
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.startCamera()
        }
        .onDisappear {
            viewModel.stopCamera()
        }
    }
}
