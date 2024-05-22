//
//  View+Extensions.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

extension View {
    func uses(_ navigation: Navigation) -> some View {
        modifier(NavigationViewModifier(navigation: navigation))
    }
}
