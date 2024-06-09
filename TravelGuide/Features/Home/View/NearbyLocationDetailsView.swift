//
//  NearbyLocationDetailsView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 9.06.2024.
//

import SwiftUI

struct NearbyLocationDetailsView: View {
    var locationModel: NearbyLocationDetail
    @State private var isFavorite: Bool = false
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            CityRemoteImage(urlString: locationModel.photos.data.first?.images.large.url ?? "")
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
                .cornerRadius(8)

            
            VStack {
                Text(locationModel.details.name)
                    .font(.headline)
                    .padding(.top, 8)
                
                if let desc = locationModel.details.description {
                    ScrollView {
                        Text(desc)
                            .font(.subheadline)
                            .padding(.top, 4)
                            .padding(.horizontal)
                    }
                } else {
                    Text("No description available.")
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.horizontal)
                }

                
                Spacer()
                
                Button(action: {
                    isFavorite.toggle()
                    if isFavorite {
                        CoreDataManager.shared.addToFavorites(locationModel)
                    } else {
                        CoreDataManager.shared.removeFromFavorites(locationModel)
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .font(.largeTitle)
                }
                .padding(.bottom, 20)
            }
            
            Spacer()
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button(action: {
            isShowingDetail = false
        }, label: {
            XDismissButton()
        }), alignment: .topTrailing)
        .onAppear {
            isFavorite = CoreDataManager.shared.isFavorite(locationModel)
        }
    }
}
