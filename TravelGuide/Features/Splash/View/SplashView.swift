//
//  SplashView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject private var navigation = Navigation()
    @State private var navigateToOnboarding = false
    
    var body: some View {
        ZStack {
            Color.appColor
                .ignoresSafeArea()
            
            VStack(spacing: 100) {
                Spacer()
                Image("Onboarding1")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .cornerRadius(10)
                Text("Travel with the help of the AI")
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                       navigateToOnboarding = true
                }
            }
        .background(
            NavigationLink(
                destination: OnboardingView(),
                                    isActive: $navigateToOnboarding,
                                    label: EmptyView.init
            )
            .hidden()
            )
        .navigationBarHidden(true)
        }
    }
    
   


#Preview {
    SplashView()
}

