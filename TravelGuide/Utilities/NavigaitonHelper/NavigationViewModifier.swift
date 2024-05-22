//
//  NavigationViewModifier.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

 struct NavigationViewModifier: ViewModifier {
    
    @ObservedObject  var navigation: Navigation
    
    public func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    destination:
                        navigation.destination
                        .onDisappear {
                            navigation.onDismiss?()
                        },
                    isActive:
                        $navigation.isPushed,
                    label: {
                        EmptyView()
                    })
            )
            .sheet(isPresented: $navigation.isPresented, onDismiss: navigation.onDismiss) {
                navigation.destination
            }
            .fullScreenCover(isPresented: $navigation.isCovered, onDismiss: navigation.onDismiss) {
                navigation.destination
            }
    }
}
