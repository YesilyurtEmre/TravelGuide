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

    var userCity: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "location")
                Text(userCity)
            }
            .padding(.horizontal)
            .foregroundColor(.blue)
        }
        .padding()
    }
}


#Preview {
    SearchView(
        searchText: .constant(""),
        userCity: ""
    )
}
