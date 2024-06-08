//
//  NearbyLocationDetail.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import Foundation

struct NearbyLocationDetail: Identifiable {
    let id = UUID()
    let details: LocationDetailResponse
    let photos: LocationPhotosResponse
}
