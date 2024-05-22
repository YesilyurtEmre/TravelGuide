//
//  OnboardingView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    
    let onBoardingPages = [
        OnboardingPage(
            image: "Onboarding1",
            title: "Step1",
            description: "Travel with the help of the AI"
        ),
        OnboardingPage(
            image: "Onboarding2",
            title: "Step2",
            description: "Travel with the help of the AI"
        ),
        OnboardingPage(
            image: "Onboarding3",
            title: "Step3",
            description: "Travel with the help of the AI"
        )
    ]
    
    @ObservedObject private var navigation = Navigation()
    @State private var currentPage = 0
    
    
    var body:some View {
        VStack {
            HStack {
                
                if currentPage == 0 {
                    Text("Hello Travellers")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                }
                else{
                    Button(action: {
                        currentPage -= 1
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                        
                        
                    })
                }
                
                Spacer()
                
                Button {
                    if currentPage > 0 {
                        currentPage -= 1
                    } else {
                        AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.IS_SHOW_ONBOARDING, value: true)
                        navigation
                            .present(.page) {
                                //LocationPermissionView()
                            }
                    }
                } label: {
                    Text("Skip")
                }
                
            }
            .padding()
            .foregroundColor(.black)
            
            Spacer(minLength: 30)
            
            TabView(selection: $currentPage) {
                ForEach(0..<onBoardingPages.count, id: \.self) { index in
                    OnboardingPageView(onboardingPage: onBoardingPages[index], currentPage: $currentPage)
                        .tag(index)
                }
            }
            
            HStack {
                
                if currentPage == 0 {
                    Color.orange.frame(height: 8 / UIScreen.main.scale)
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                }
                else if currentPage == 1 {
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                    Color.orange.frame(height: 8 / UIScreen.main.scale)
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                }
                else if currentPage == 2 {
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                    Color.gray.frame(height: 8 / UIScreen.main.scale)
                    Color.orange.frame(height: 8 / UIScreen.main.scale)
                }
                
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            Button {
                if self.currentPage < onBoardingPages.count - 1  {
                    self.currentPage += 1
                } else {
                    AppLocalStorage.shared.saveValue(forKey: LocalStorageKeys.IS_SHOW_ONBOARDING, value: true)
                    navigation
                        .present(.page) {
                            LocationPermissionView()
                        }
                }
            } label: {
                VStack {
                    if currentPage < onBoardingPages.count - 1 {
                        Text("Next")
                    } else {
                        Text("Get Started")
                    }
                }
                .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(40)
                .padding(.horizontal, 16)
            }
               
            
        }
        .uses(navigation)
        .navigationBarHidden(true)
    }
}

#Preview {
    OnboardingView()
}
