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
    @State
    private var currentIndex: Int = 0
    @State
    private var timer: Timer?
    
    @ObservedObject
    private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchView(
                searchText: $searchText,
                userCity: AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY) ?? "Konum belirlenemedi"
            )
            
            ScrollView {
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    if let locationDetail = viewModel.locationDetail,
                       let locationPhotos = viewModel.locationPhotos {
                        sliderView(photos: locationPhotos.data)
                        aboutCityView()
                    }
                    
                    // sonrada aşağıdaki populer yerler listelencek.
                    
                    if viewModel.alertItem == nil {
                        if let userCity = AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY) ?? "" {
                            Text("\(userCity)'un En Popüler Yerleri")
                                .font(.title)
                                .padding(.horizontal)
                        }
                        
                        //PopularPlacesListView(popularPlaces: popularPlaces)
                        
                        Spacer()
                    }
                    
                    if viewModel.alertItem != nil {
                        Spacer()
                    }
                }
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func sliderView(photos: [LocationPhoto]) -> some View {
        VStack {
             TabView(selection: $currentIndex) {
                 ForEach(photos.indices, id: \.self) { index in
                     CityRemoteImage(urlString: photos[index].images.original.url)
                         .scaledToFill()
                         .tag(index)
                         .frame(height: 300)
                         .clipped()
                 }
             }
             .tabViewStyle(PageTabViewStyle())
             .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
             .frame(height: 300)
             .onAppear {
                 startTimer(photos: photos)
             }
             .onDisappear {
                 stopTimer()
             }
         }
         .frame(maxWidth: .infinity)
         .padding(.horizontal, 20)
    }
    
    func startTimer(photos: [LocationPhoto]) {
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % photos.count
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    @ViewBuilder
    private func aboutCityView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About \(AppLocalStorage.shared.readValue(forKey: LocalStorageKeys.USER_CITY) ?? "")")
                .font(.title2)
                .bold()
                .padding(.horizontal)
            
            Text(viewModel.locationDetail?.description ?? "")
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}


#Preview {
    HomeView()
}
