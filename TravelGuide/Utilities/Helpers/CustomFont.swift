//
//  CustomFont.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import SwiftUI

enum CustomFont: String {
    case regular = "Inter-Regular"
    case bold = "Inter-Bold"
    
    func size(_ size: CGFloat) -> Font {
        return Font.custom(self.rawValue, size: size)
    }
}
