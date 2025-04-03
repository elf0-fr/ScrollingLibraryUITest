//
//  CarouselOneElement.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselOneElement: View {
    var body: some View {
        Carousel {
            Color.blue
        }
    }
}

#Preview {
    CarouselOneElement()
}

extension Views {
    static let carouselOneElement = Views(rawValue: "02: One Element")
}
