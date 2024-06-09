//
//  GalleryView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import CoreML
import SwiftUI
import Vision

struct GalleryView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var classificationResult = ""
    @State private var isShowSearchButton = true
    @State private var navigateToHome = false
    @EnvironmentObject var sharedData: SharedData
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.isShowingImagePicker.toggle()
                }) {
                    Image(systemName: "photo")
                        .font(.title)
                        .padding()
                }
            }
            
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .padding()
                
                HStack {
                    Text(classificationResult)
                        .font(.body)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    if isShowSearchButton {
                        Button {
                            tabSelection = 0
                            sharedData.textValue  = classificationResult
                        } label: {
                            Text("Search")
                                .customFont(.regular, size: 12)
                                .foregroundColor(.appColor)
                        }
                        .padding(.trailing, 16)
                    }
                    
                }
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .padding()
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: self.$selectedImage, isShown: self.$isShowingImagePicker)
                .onDisappear {
                    // Galeriden resim seçildiğinde sınıflandırma işlemi yap
                    if let image = selectedImage, let ciImage = CIImage(image: image) {
                        classifyImage(ciImage)
                    }
                }
        }
    }
    
    func classifyImage(_ image: CIImage) {
        guard let model = try? VNCoreMLModel(for: LandmarkClassifier().model) else {
            fatalError("Model yüklenemedi")
            
        }
        
       let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                self.classificationResult = "Sınıflandırma başarısız"
                self.isShowSearchButton = false
                return
            }
            
            
            self.classificationResult = topResult.identifier
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            self.classificationResult = "Sınıflandırma başarısız"
            self.isShowSearchButton = false
        }
    }
}
