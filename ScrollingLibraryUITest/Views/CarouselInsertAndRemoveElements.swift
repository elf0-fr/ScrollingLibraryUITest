//
//  CarouselInsertAndRemoveElements.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI
import ScrollingLibrary

struct CarouselInsertAndRemoveElements: View {
    @State private var count: Int = 5
    
    @State private var items: [Color] = []
    
    var body: some View {
        VStack {
            GroupBox {
                Stepper("Add or remove", value: $count, in: 0...10)
                    .accessibilityIdentifier("stepper")
            }
            Carousel(items, id: \.self) { item in
                item
            }
        }
        .onAppear {
            items = Array(0..<count).map { _ in
                Color(
                    red: Double.random(in: 0.0...1.0),
                    green: Double.random(in: 0.0...1.0),
                    blue: Double.random(in: 0.0...1.0)
                )
            }
        }
        .onChange(of: count) { oldValue, newValue in
            if newValue > oldValue {
                items.append(Color(
                    red: Double.random(in: 0.0...1.0),
                    green: Double.random(in: 0.0...1.0),
                    blue: Double.random(in: 0.0...1.0)
                ))
            } else {
                items.removeLast()
            }
        }
    }
}

#Preview {
    CarouselInsertAndRemoveElements()
}

extension Views {
    static let carouselInsertAndRemoveElements = Views(rawValue: "05: Insert and remove elements")
}
