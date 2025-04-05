//
//  LibraryUITests.swift
//  LibraryUITests
//
//  Created by Elfo on 27/03/2025.
//

import XCTest

final class LibraryUITests: XCTestCase {
    let app = XCUIApplication()
    var searchField: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app.launch()
        
        searchField = app.searchFields["Search"]
        XCTAssert(searchField.waitForExistence(timeout: 3))
        searchField.tap()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
    }
    
    private func swipeLeft(carousel: XCUIElement) {
#if os(iOS) || os(visionOS)
        carousel.swipeLeft(velocity: .slow)
#else
        carousel.scroll(byDeltaX: -1000, deltaY: 0)
#endif
    }
    
    private func swipeRight(carousel: XCUIElement) {
#if os(iOS) || os(visionOS)
        carousel.swipeRight(velocity: .slow)
#else
        carousel.scroll(byDeltaX: 1000, deltaY: 0)
#endif
    }
    
    private func getIncrementButton(for stepper: XCUIElement) -> XCUIElement {
#if os(iOS)
        stepper.buttons["stepper-Increment"]
#elseif os(visionOS)
        stepper.buttons["plus"]
#else
        stepper.incrementArrows.firstMatch
#endif
    }
    
    private func getDecrementButton(for stepper: XCUIElement) -> XCUIElement {
#if os(iOS)
        stepper.buttons["stepper-Decrement"]
#elseif os(visionOS)
        stepper.buttons["minus"]
#else
        stepper.decrementArrows.firstMatch
#endif
    }

    func testEmpty() throws {
        searchField.firstMatch.typeText("01")
        app.buttons["01: Empty"].tap()
          
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        XCTAssertEqual(carousel.frame.size.height, 0)
        
        XCTAssert(carousel.otherElements["carouselElement_0"].waitForNonExistence(timeout: 3))
    }
    
    func testOneElement() throws {
        searchField.firstMatch.typeText("02")
        app.buttons["02: One Element"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        XCTAssertNotEqual(carousel.frame.size.height, 0, accuracy: 5)
        XCTAssertNotEqual(carousel.frame.size.width, 0, accuracy: 5)

        for index in 0..<3 {
            let childIdentifier = "carouselElement_\(index)"
            let child = carousel.otherElements[childIdentifier]
            XCTAssert(child.waitForExistence(timeout: 3))
        }
        XCTAssert(carousel.otherElements["carouselElement_3"].waitForNonExistence(timeout: 3))
        
        XCTAssert(carousel.otherElements["carouselElement_1"].wait(for: \.isHittable, toEqual: true, timeout: 3))
//        carousel.swipeLeft(velocity: .slow)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_1"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
    
    func testTwoElements() throws {
        searchField.firstMatch.typeText("03")
        app.buttons["03: Two Elements"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        XCTAssertNotEqual(carousel.frame.size.height, 0, accuracy: 5)
        XCTAssertNotEqual(carousel.frame.size.width, 0, accuracy: 5)
        
        for index in 0..<6 {
            let childIdentifier = "carouselElement_\(index)"
            let child = carousel.otherElements[childIdentifier]
            XCTAssert(child.waitForExistence(timeout: 3))
        }
        XCTAssert(carousel.otherElements["carouselElement_6"].waitForNonExistence(timeout: 3))
        
        XCTAssert(carousel.otherElements["carouselElement_2"].wait(for: \.isHittable, toEqual: true, timeout: 3))
//        carousel.swipeLeft(velocity: .slow)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_3"].wait(for: \.isHittable, toEqual: true, timeout: 3))
//        carousel.swipeLeft(velocity: .slow)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_2"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
    
    func testThreeElements() throws {
        searchField.firstMatch.typeText("04")
        app.buttons["04: Three Elements"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        XCTAssertNotEqual(carousel.frame.size.height, 0, accuracy: 5)
        XCTAssertNotEqual(carousel.frame.size.width, 0, accuracy: 5)
        
        for index in 0..<9 {
            let childIdentifier = "carouselElement_\(index)"
            let child = carousel.otherElements[childIdentifier]
            XCTAssert(child.waitForExistence(timeout: 3))
        }
        XCTAssert(carousel.otherElements["carouselElement_9"].waitForNonExistence(timeout: 3))
        
        // Blue is hittable
        XCTAssert(carousel.otherElements["carouselElement_3"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Yellow is hittable
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Red is hittable
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_5"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Blue is hittable
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_3"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Red is hittable
        swipeRight(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_5"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
    
    func testInsertAndRemoveElements() throws {
        searchField.firstMatch.typeText("05")
        app.buttons["05: Insert and remove elements"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        
        let stepper = app.steppers["stepper"]
        XCTAssert(stepper.waitForExistence(timeout: 3))
        
        let incrementButton = getIncrementButton(for: stepper)
        let decrementButton = getDecrementButton(for: stepper)
        XCTAssert(incrementButton.waitForExistence(timeout: 3))
        XCTAssert(decrementButton.waitForExistence(timeout: 3))
        
        // Five subviews
        for index in 0..<15 {
            let childIdentifier = "carouselElement_\(index)"
            let child = carousel.otherElements[childIdentifier]
            XCTAssert(child.waitForExistence(timeout: 3))
        }
        XCTAssert(carousel.otherElements["carouselElement_5"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Four subviews
        decrementButton.tap()
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Three subviews
        decrementButton.tap()
        XCTAssert(carousel.otherElements["carouselElement_3"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Second page
        swipeLeft(carousel: carousel)
        // Four subviews
        incrementButton.tap()
        XCTAssert(carousel.otherElements["carouselElement_5"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Last page
        swipeLeft(carousel: carousel)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_7"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Three subviews -> The page index is the first subview.
        decrementButton.tap()
        XCTAssert(carousel.otherElements["carouselElement_3"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
    
    func testUpdateOneElement() throws {
        searchField.firstMatch.typeText("06")
        app.buttons["06: Update One Element"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        
        let button = app.buttons["Update The Third Element"]
        XCTAssert(button.waitForExistence(timeout: 3))
        
        // Four subviews
        for index in 0..<12 {
            let childIdentifier = "carouselElement_\(index)"
            let child = carousel.otherElements[childIdentifier]
            XCTAssert(child.waitForExistence(timeout: 3))
        }
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Third page
        swipeLeft(carousel: carousel)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_6"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        // Update the third page
        button.tap()
        XCTAssert(carousel.otherElements["carouselElement_6"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
    
    func testAutoScrollingByDefault() throws {
        searchField.firstMatch.typeText("07")
        app.buttons["07: Auto Scrolling by Default"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        
        // Auto scrolling
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        XCTAssert(carousel.otherElements["carouselElement_5"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        sleep(2)
        XCTAssert(carousel.otherElements["carouselElement_6"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        sleep(2)
        XCTAssert(carousel.otherElements["carouselElement_7"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        sleep(2)
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Manual scrolling
        swipeLeft(carousel: carousel)
        swipeLeft(carousel: carousel)
        XCTAssert(carousel.otherElements["carouselElement_6"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        
        // Auto scrolling
        sleep(2)
        XCTAssert(carousel.otherElements["carouselElement_7"].wait(for: \.isHittable, toEqual: true, timeout: 3))
        sleep(2)
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
}
