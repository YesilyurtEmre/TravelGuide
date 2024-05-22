//
//  HomeView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI
import CoreLocation

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchText)
                .padding(.leading, 24)
                .padding(.vertical, 10)
                .padding(.trailing, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                        
                        if isSearching {
                            Button(action: {
                                searchText = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                )
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                })
                .transition(.move(edge: .trailing))
                // .animation(.default)
            }
        }
        .navigationBarHidden(isSearching)
    }
}


struct HomeView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @StateObject var locationManager = LocationManager.shared
    @State private var userCity: String?
   
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    HStack {
                        SearchBar(searchText: $searchText, isSearching: $isSearching)
                            .padding(.top)
                        
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        
                        Text(locationManager.userCity ?? "")
                            .foregroundColor(.blue)
                            .padding(.leading, 2)
                            .padding(.trailing,2)
                        
                        
                    }
                    Spacer(minLength: 20)
                    Text("Home Screen")
                    Spacer()
                }
            }
            .navigationTitle("Home")
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            Text("CoreML Screen")
                .tabItem {
                    Image(systemName: "camera.on.rectangle")
                    Text("CoreML")
                    
                }
            Text("Favorites")
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Fav")
                }
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}


#Preview {
    HomeView()
    
}
