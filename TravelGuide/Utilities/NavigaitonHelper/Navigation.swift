//
//  Navigation.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 22.05.2024.
//

import SwiftUI

final class Navigation: ObservableObject {
    
    @Published public var isPushed = false
    @Published public var isPresented = false
    @Published public var isCovered = false
    @Published public var destination: AnyView?
    @Published public var onDismiss: (() -> Void)?
    
     func present<Destination: View>(_ type: NavigationType, @ViewBuilder destination: () -> (Destination), onDismiss: (() -> Void)? = nil) {
        self.destination = AnyView(destination())
        switch type {
        case .page:
            self.onDismiss = onDismiss
            isPushed = true
        case .sheet:
            self.onDismiss = onDismiss
            isPresented = true
        case .fullScreenCover:
            self.onDismiss = onDismiss
            isCovered = true
        }
    }
    
}
