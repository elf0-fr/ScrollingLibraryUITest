//
//  CarouselUpdateOneElement.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 04/04/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselUpdateOneElement: View {
    
    @State private var items: [Color] = [
        .blue, .yellow, .red, .green
    ]
    
    var body: some View {
        VStack {
            Group {
                Button("Update The Third Element") {
                    items[2] = .purple
                }
            }
            Carousel(items.indices, id: \.self) { index in
                items[index]
            }
        }
    }
}

#Preview {
    CarouselUpdateOneElement()
}

extension Views {
    static let carouselUpdateOneElement = Views(rawValue: "06: Update One Element")
}
