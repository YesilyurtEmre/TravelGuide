//
//  LocationCardView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import SwiftUI

struct LocationCardView: View {
    
    var locationModel: NearbyLocationDetail
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            imageView()
            infoView()
        }
        .frame(width: 137, height: 200)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func imageView() -> some View {
        CityRemoteImage(urlString: locationModel.photos.data.first?.images.large.url ?? "")
            .frame(width: 137, height: 170)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
    }
    
    @ViewBuilder
    private func infoView() -> some View {
        Text(locationModel.details.name)
            .customFont(.regular, size: 12)
            .foregroundColor(.black)
    }
}
