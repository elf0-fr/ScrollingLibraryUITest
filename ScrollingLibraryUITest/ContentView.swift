//
//  ContentView.swift
//  ScrollingLibraryUITest
//
//  Created by Elfo on 27/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    
    let views: [Views] = [
        .carouselEmpty,
        .carouselOneElement,
        .carouselTwoElements,
        .carouselThreeElements,
        .carouselInsertAndRemoveElements,
        .carouselUpdateOneElement,
        .carouselAutoScrolling
    ]
    
    var searchResult: [Views] {
        return if searchText.isEmpty {
            views
        } else {
            views.filter { $0.rawValue.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResult) { result in
                    NavigationLink(result.rawValue, value: result)
                }
            }
            .navigationDestination(for: Views.self) { value in
                switch value {
                case .carouselEmpty:
                    CarouselEmpty()
                    
                case .carouselOneElement:
                    CarouselOneElement()
                    
                case .carouselTwoElements:
                    CarouselTwoElements()
                    
                case .carouselThreeElements:
                    CarouselThreeElements()
                    
                case .carouselInsertAndRemoveElements:
                    CarouselInsertAndRemoveElements()
                    
                case .carouselUpdateOneElement:
                    CarouselUpdateOneElement()
                    
                case .carouselAutoScrolling:
                    CarouselAutoScrolling()
                
                default:
                    ContentUnavailableView("Case not handled", systemImage: "exclamationmark.circle")
                }
            }
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    ContentView()
}
