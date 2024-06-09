//
//  FavoritesView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject
    private var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favoriteLocations, id: \.self) { location in
                    HStack {
                        CityRemoteImage(urlString: location.imageUrl ?? "")
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(location.name ?? "Unknown Location")
                                .font(.headline)
                            
                            Text(location.desc?.prefix(30) ?? "No description available.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
            .onAppear {
                viewModel.fetchFavorites()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        offsets.map { viewModel.favoriteLocations[$0] }.forEach { location in
            viewModel.removeFromFavorites(location)
        }
    }
}
