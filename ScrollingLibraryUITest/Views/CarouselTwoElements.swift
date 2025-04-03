//
//  CarouselTwoElements.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselTwoElements: View {
    var body: some View {
        Carousel {
            Color.blue
            Color.yellow
        }
    }
}

#Preview {
    CarouselTwoElements()
}

extension Views {
    static let carouselTwoElements = Views(rawValue: "03: Two Elements")
}
