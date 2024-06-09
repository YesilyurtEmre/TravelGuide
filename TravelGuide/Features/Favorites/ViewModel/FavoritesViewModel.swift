//
//  FavoritesViewModel.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 9.06.2024.
//

import SwiftUI
import CoreData

class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteLocations: [FavoriteLocation] = []
    
    init() {
        fetchFavorites()
    }
    
    func fetchFavorites() {
        favoriteLocations = CoreDataManager.shared.fetchFavorites()
    }
    
    func removeFromFavorites(_ location: FavoriteLocation) {
        CoreDataManager.shared.persistentContainer.viewContext.delete(location)
        CoreDataManager.shared.saveContext()
        fetchFavorites()
    }
}
