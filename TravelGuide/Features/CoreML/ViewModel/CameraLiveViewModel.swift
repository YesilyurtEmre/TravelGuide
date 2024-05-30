//
//  CameraLiveViewModel.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI
import AVFoundation
import Vision

class CameraLiveViewModel: NSObject, ObservableObject {
    private let videoCapture = VideoCapture()
    private let classificationModel = LandmarkClassifier()
    private var request: VNCoreMLRequest?
    private var visionModel: VNCoreMLModel?

    @Published var label: String = ""
    @Published var confidence: String = ""
    var previewLayer: AVCaptureVideoPreviewLayer?

    override init() {
        super.init()
        setUpModel()
        setUpCamera()
    }

    func setUpModel() {
        guard let visionModel = try? VNCoreMLModel(for: classificationModel.model) else {
            fatalError("CoreML Model yüklenemedi.")
        }
        self.visionModel = visionModel
        request = VNCoreMLRequest(model: visionModel) { [weak self] request, error in
            guard let results = request.results else {
                return
            }
            if let classificationResults = results as? [VNClassificationObservation], let firstResult = classificationResults.first {
                DispatchQueue.main.async {
                    self?.label = firstResult.identifier
                    self?.confidence = "\(Int(firstResult.confidence * 100))%"
                }
            }
        }
        request?.imageCropAndScaleOption = .scaleFill
    }

    func setUpCamera() {
        videoCapture.delegate = self
        videoCapture.setUp(sessionPreset: .vga640x480) { [weak self] success in
            if success, let previewLayer = self?.videoCapture.previewLayer {
                DispatchQueue.main.async {
                    self?.previewLayer = previewLayer
                    self?.startCamera()
                }
            }
        }
    }

    func startCamera() {
        DispatchQueue.global(qos: .background).async { [weak self] in
                    self?.videoCapture.start()
                }
    }

    func stopCamera() {
        videoCapture.stop()
    }
}

extension CameraLiveViewModel: VideoCaptureDelegate {
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?) {
        guard let pixelBuffer = pixelBuffer else {
            return
        }
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request!])
    }
}
