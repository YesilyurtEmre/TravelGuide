//
//  CoreDataManager.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 9.06.2024.
//

import CoreData
import SwiftUI

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FavoriteLocationsModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    func fetchFavorites() -> [FavoriteLocation] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteLocation> = FavoriteLocation.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching favorites: \(error)")
            return []
        }
    }
    
    func addToFavorites(_ location: NearbyLocationDetail) {
        let context = persistentContainer.viewContext
        let favorite = FavoriteLocation(context: context)
        favorite.id = location.details.locationID
        favorite.name = location.details.name
        favorite.desc = location.details.description
        favorite.imageUrl = location.photos.data.first?.images.large.url
        
        saveContext()
    }
    
    func removeFromFavorites(_ location: NearbyLocationDetail) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteLocation> = FavoriteLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", location.details.locationID)
        
        if let result = try? context.fetch(fetchRequest), let favorite = result.first {
            context.delete(favorite)
            saveContext()
        }
    }
    
    func isFavorite(_ location: NearbyLocationDetail) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteLocation> = FavoriteLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", location.details.locationID)
        
        if let result = try? context.fetch(fetchRequest), let _ = result.first {
            return true
        }
        
        return false
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
