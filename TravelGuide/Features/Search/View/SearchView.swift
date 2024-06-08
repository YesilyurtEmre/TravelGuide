//
//  SearchView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 26.05.2024.
//

import SwiftUI

struct SearchView: View {
    
    @Binding
    var searchText: String
    
    var body: some View {
        TextField("Search", text: $searchText)
            .padding()
            .frame(height: 60)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}
