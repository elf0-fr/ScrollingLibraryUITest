//
//  CarouselAutoScrollingByDefault.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 04/04/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselAutoScrollingByDefault: View {
    var body: some View {
        Carousel {
            Color.blue
            Color.yellow
            Color.red
            Color.green
        }
        .autoScrollingEnabled(true)
    }
}

#Preview {
    CarouselAutoScrollingByDefault()
}

extension Views {
    static let carouselAutoScrollingByDefault = Views(rawValue: "07: Auto Scrolling by Default")
}
