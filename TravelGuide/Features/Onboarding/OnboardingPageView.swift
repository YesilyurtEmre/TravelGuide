//
//  OnboardingPageView.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    let onboardingPage: OnboardingPage
    @Binding var currentPage: Int
    
    var body: some View {
        VStack {
            Image(onboardingPage.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .frame(height: 300)
            
            
            Spacer(minLength: 80)
            
            Text(onboardingPage.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .kerning(1.3)
                .padding(.top)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
                .lineLimit(nil)
                .fixedSize(horizontal: true, vertical: false)
            
            Text(onboardingPage.description)
                .font(.body)
                .fontWeight(.regular)
                .kerning(1.3)
                .padding([.leading, .trailing])
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 0)
        }
        .id(currentPage)
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(onboardingPage: OnboardingPageMockData.sampleOnboardingPage, currentPage: .constant(0))
    }
}
