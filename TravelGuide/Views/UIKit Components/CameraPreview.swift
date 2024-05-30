//
//  CameraPreview.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    @Binding var previewLayer: AVCaptureVideoPreviewLayer?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let previewLayer = previewLayer else { return }
        previewLayer.frame = uiView.bounds
        uiView.layer.addSublayer(previewLayer)
    }
}

