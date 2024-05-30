//
//  RemoteImage.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 30.05.2024.
//

import SwiftUI

final class ImageLoader: ObservableObject {

    @Published
    var image: Image? = nil

    func load(fromURLString urlString: String) {
        Task {
            do {
                if let uiImage = try await APIRequest.shared.downloadImage(fromURLString: urlString) {
                    DispatchQueue.main.async {
                        self.image = Image(uiImage: uiImage)
                    }
                }
            } catch {
                print("Error loading image: \(error)")
            }
        }
    }
}

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("noImagePlaceholder").resizable()
    }
}

struct CityRemoteImage: View {
    
    @StateObject
    var imageLoader = ImageLoader()

    let urlString: String

    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}

#Preview {
    RemoteImage()
}
