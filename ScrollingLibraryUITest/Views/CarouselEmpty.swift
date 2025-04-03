//
//  CarouselEmpty.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselEmpty: View {
    var body: some View {
        Carousel { }
    }
}

extension Views {
    static let carouselEmpty = Views(rawValue: "01: Empty")
}
