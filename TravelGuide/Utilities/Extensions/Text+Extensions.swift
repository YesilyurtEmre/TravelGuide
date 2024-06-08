//
//  Text+Extensions.swift
//  TravelGuide
//
//  Created by Emre Yeşilyurt on 8.06.2024.
//

import SwiftUI

extension Text {
    func customFont(_ font: CustomFont, size: CGFloat) -> some View {
        self.font(font.size(size))
    }
}
