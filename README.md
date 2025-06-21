# Welcome to ScrollingLibraryUITest

This application is designed to test my Swift package’s UI ([ScrollingLibrary](https://github.com/elf0-fr/ScrollingLibrary/tree/main)) using XCUITest.

```
func testAutoScrollingByDefault() throws {
        searchField.firstMatch.typeText("07")
        app.buttons["07: Auto Scrolling"].tap()
        
        let carousel = app.scrollViews["carousel"]
        XCTAssert(carousel.waitForExistence(timeout: 3))
        
        let toggle = getSwitch(for: "toggle")
        #if !os(macOS)
        // Observation: checking for existence fails the next XCTAssert on macOS
        XCTAssert(toggle.waitForExistence(timeout: 3))
        #endif
        
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
        
        // Auto scrolling disabled
        toggle.tap()
        sleep(3)
        XCTAssert(carousel.otherElements["carouselElement_4"].wait(for: \.isHittable, toEqual: true, timeout: 3))
    }
```
