//
//  HomeView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct HomeView: View {

    @State
    private var searchText = ""

    @ObservedObject
    private var viewModel = HomeViewModel()
   
    var body: some View {
        VStack(alignment: .leading) {
            SearchView(
                searchText: $searchText,
                userCity: AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY) ?? "Konum belirlenemedi"
            )
            
            Spacer()
            
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    HomeView()
}
