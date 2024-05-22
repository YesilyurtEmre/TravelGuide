//
//  OnboardingPage.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import Foundation

struct OnboardingPage {
    let image: String
    let title: String
    let description: String
}

struct OnboardingPageMockData {
    static let sampleOnboardingPage = OnboardingPage(
        image: "Image1",
        title: "Step1",
        description: "Travel with the help of the AI"
    )
}

