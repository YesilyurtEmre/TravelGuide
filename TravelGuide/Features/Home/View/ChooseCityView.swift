//
//  ChooseCityView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import SwiftUI

struct ChooseCityView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var userCity: String?
    @State private var selectedCity: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.green)
                }
                Spacer()
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            
            Image(systemName: "map")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 50)
            
            Text("Choose a City")
                .font(.largeTitle)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Config.shared.places, id: \.self) { place in
                        Text(place)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(place == userCity ? Color.red : (selectedCity == place ? Color.green : Color.gray), lineWidth: 1)
                            )
                            .onTapGesture {
                                selectedCity = place
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            Button(action: {
                if selectedCity != userCity && !selectedCity.isEmpty {
                    userCity = selectedCity
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Continue")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(selectedCity != userCity && !selectedCity.isEmpty ? Color.appColor : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(selectedCity == userCity || selectedCity.isEmpty)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}
