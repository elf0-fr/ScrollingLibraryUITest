//
//  CarouselThreeElements.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselThreeElements: View {
    var body: some View {
        Carousel {
            Color.blue
            Color.yellow
            Color.red
        }
    }
}

#Preview {
    CarouselThreeElements()
}

extension Views {
    static let carouselThreeElements = Views(rawValue: "04: Three Elements")
}
