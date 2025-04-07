//
//  CarouselAutoScrollingByDefault.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 04/04/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselAutoScrolling: View {
    @State private var autoScrolling = true
//    @State private var scrollingDirection: LayoutDirection = .leftToRight
    
    var body: some View {
        VStack {
            GroupBox {
                Toggle("Is auto scrolling enabled?", isOn: $autoScrolling)
                    .accessibilityIdentifier("toggle")
                    .toggleStyle(.switch)
            }
            
            Carousel {
                Color.blue
                Color.yellow
                Color.red
                Color.green
            }
            .autoScrollingEnabled(autoScrolling)
//            .autoScrollDirection(scrollingDirection)
        }
    }
}

#Preview {
    CarouselAutoScrolling()
}

extension Views {
    static let carouselAutoScrolling = Views(rawValue: "07: Auto Scrolling")
}
