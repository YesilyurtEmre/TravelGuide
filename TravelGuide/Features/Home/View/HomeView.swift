//
//  HomeView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State
    private var searchText = "Eiffel"
    @State
    private var currentIndex: Int = 0
    @State
    private var timer: Timer?
    @State
    private var showingChooseCityView = false
    @State
    private var isShowCoreMLModel = false
    
    @Binding
    var tabSelection: Int
    
    @EnvironmentObject
    var sharedData: SharedData
    @StateObject
    private var viewModel = HomeViewModel()
    @ObservedObject
    private var locationPermissionViewModel = LocationPermissionViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                chooseCityView()
                searchView()
                
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        if let _ = viewModel.locationDetail,
                           let locationPhotos = viewModel.locationPhotos {
                            sliderView(photos: locationPhotos.data)
                            nearbyLocationsView()
                            aboutCityView()
                        }
                        if viewModel.alertItem != nil {
                            Spacer()
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            if viewModel.isShowingDetail, let selectedLocation = viewModel.selectedLocation {
                NearbyLocationDetailsView(
                    locationModel: selectedLocation,
                    isShowingDetail: $viewModel.isShowingDetail
                )
            }
        }
        .fullScreenCover(isPresented: $showingChooseCityView) {
            ChooseCityView(userCity: $locationPermissionViewModel.userCity, isShowCoreMLModel: $isShowCoreMLModel)
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .navigationBarHidden(true)
        .onChange(of: sharedData.textValue) { newValue in
            guard let locationId = Config.shared.coreMLIds[newValue] else { return }
            Task {
                isShowCoreMLModel = true
                await viewModel.searchLocation(locationId: locationId)
            }
        }
        .onChange(of: isShowCoreMLModel) { newValue in
            if !newValue {
                sharedData.textValue = ""
            }
        }
        .onChange(of: locationPermissionViewModel.userCity) { newCity in
            if let newCity = newCity {
                Task {
                    await viewModel.searchLocation(locationId: Config.shared.placesIds[newCity] ?? "")
                }
            }
        }
    }
    
    @ViewBuilder
    private func chooseCityView() -> some View {
        HStack {
            Spacer()
            Text(locationPermissionViewModel.userCity!)
            Button(action: {
                showingChooseCityView = true
            }) {
                Image(systemName: "chevron.down")
            }
        }
        
    }
    
    @ViewBuilder
    private func searchView() -> some View {
        TextField("Search", text: $sharedData.textValue)
            .padding()
            .frame(height: 60)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
    
    @ViewBuilder
    private func nearbyLocationsView() -> some View {
        VStack {
            HStack {
                Text("Nearby Locations")
                    .customFont(.bold, size: 14)
                    .foregroundColor(.appColor)
                
                Spacer()
            }
            .padding(.bottom, 12)
            
            locationCardsView()
            
        }
        .padding(.top, 16)
    }
    
    @ViewBuilder
    private func locationCardsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.nearbyLocationDetails.filter { !$0.photos.data.isEmpty }) { model in
                    LocationCardView(locationModel: model)
                        .onTapGesture {
                            viewModel.selectedLocation = model
                            viewModel.isShowingDetail = true
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private func sliderView(photos: [LocationPhoto]) -> some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(photos.indices, id: \.self) { index in
                    CityRemoteImage(urlString: photos[index].images.large.url)
                        .scaledToFill()
                        .tag(index)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(8)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 200)
            .onAppear {
                startTimer(photos: photos)
            }
            .onDisappear {
                stopTimer()
            }
        }
        .frame(maxWidth: .infinity)
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
            if let city = locationPermissionViewModel.userCity {
                if isShowCoreMLModel {
                    Text("About \(searchText)")
                        .customFont(.bold, size: 14)
                        .foregroundColor(.appColor)
                } else {
                    Text("About \(city)")
                        .customFont(.bold, size: 14)
                        .foregroundColor(.appColor)
                }
                
                Text(viewModel.locationDetail?.description ?? "Can not find any information about \(city) !!")
                    .customFont(.regular, size: 12)
            }
        }
    }
}
