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
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Galeri seçimini başlat
                    self.isShowingImagePicker.toggle()
                }) {
                    Image(systemName: "photo")
                        .font(.title)
                        .padding()
                }
            }
            
            // Burada, yalnızca galeri açıldığında görüntülenmesi gereken resim yer alıyor
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .padding()
                
                Text(classificationResult)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
                    .padding()
            }
        }
        // .sheet çağrısını düzenle, ImagePicker'ı sadece galeri açıldığında göster
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
        // Core ML modelini yükle
        guard let model = try? VNCoreMLModel(for: LandmarkClassifier().model) else {
            fatalError("Model yüklenemedi")
            
        }
        
        // Vision isteği oluştur ve sınıflandırmayı gerçekleştir
       let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                self.classificationResult = "Sınıflandırma başarısız"
                return
            }
            
            // Sınıflandırma sonucunu al
            self.classificationResult = topResult.identifier
            let confidence = topResult.confidence
           print("Classification result: \(classificationResult), Confidence: \(confidence)")
        }
        
        

        
        // Vision isteğini oluşturulan resim üzerinde çalıştır
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            self.classificationResult = "Sınıflandırma başarısız: \(error.localizedDescription)"
        }
    }
}
