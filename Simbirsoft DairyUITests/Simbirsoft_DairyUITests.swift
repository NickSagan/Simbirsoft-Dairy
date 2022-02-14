//
//  Simbirsoft_DairyUITests.swift
//  Simbirsoft DairyUITests
//
//  Created by Nick Sagan on 13.02.2022.
//

import XCTest

class Simbirsoft_DairyUITests: XCTestCase {
    
    func testAddTaskUserInput() throws {
        let app = XCUIApplication()
        app.launch()
        let nameField = app.textFields["inputName"]
        let descField = app.textViews["inputDescription"]
        let skipButton = app.buttons["skip"]
        let addButtonAtCalendar = app.buttons["addButtonCalendarVC"]

        app.swipeLeft()
        app.swipeLeft()
        skipButton.tap()
        addButtonAtCalendar.tap()
        nameField.tap()
        nameField.typeText("Test task")
        descField.tap()
        descField.typeText("Test desc")
        app.tapCoordinate(at: CGPoint(x: app.frame.maxX - 30, y: app.frame.minY + 40))
        app.tapCoordinate(at: CGPoint(x: 20, y: 20))
        app.navigationBars.buttons.element(boundBy: 0).tap()

    }


//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
}

extension XCUIApplication {
    func tapCoordinate(at point: CGPoint) {
        let normalized = coordinate(withNormalizedOffset: .zero)
        let offset = CGVector(dx: point.x, dy: point.y)
        let coordinate = normalized.withOffset(offset)
        coordinate.tap()
    }
}
