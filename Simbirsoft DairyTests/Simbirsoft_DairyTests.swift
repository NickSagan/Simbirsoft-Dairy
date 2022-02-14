//
//  Simbirsoft_DairyTests.swift
//  Simbirsoft DairyTests
//
//  Created by Nick Sagan on 13.02.2022.
//

import XCTest
@testable import Simbirsoft_Dairy

class Simbirsoft_DairyTests: XCTestCase {

    func testAdapterGetTasksFromEvents() throws {
        let adapter = Adapter()
        let testEvent = EventModel()
        testEvent.id = 42
        testEvent.text = "My task 555%!-="
        testEvent.description = "Описание моего дела Name 999%!-="
        testEvent.dateInterval = DateInterval(start: Date(timeIntervalSince1970: 147600000), end: Date(timeIntervalSince1970: 147610000))
        let result = adapter.getTasks(from: [testEvent])
         
        XCTAssertNotNil(result[0])
        XCTAssertTrue(result.count == 1)
        XCTAssertEqual(result[0].name, "My task 555%!-=")
        XCTAssertEqual(result[0].description, "Описание моего дела Name 999%!-=")
        XCTAssertEqual(result[0].id, 42)
        XCTAssertEqual(result[0].date_start, 147600000)
        XCTAssertEqual(result[0].date_finish, 147610000)
    }
    
    func testAdapterGetEventsFromTasks() {
        let adapter = Adapter()
        let testTask = TaskModel(id: 11, date_start: 147600008, date_finish: 147610008, name: " Task In English 123-=!@#$%ˆ&*()_", description: " описание на русском 123-=!@#$%ˆ&*()_")
        let result = adapter.getEvents(from: [testTask, testTask, testTask])
         
        XCTAssertNotNil(result[2])
        XCTAssertTrue(result.count == 3)
        XCTAssertEqual(result[0].text, " Task In English 123-=!@#$%ˆ&*()_")
        XCTAssertEqual(result[1].description, " описание на русском 123-=!@#$%ˆ&*()_")
        XCTAssertEqual(result[2].id, 11)
        XCTAssertEqual(result[0].dateInterval, DateInterval(start: Date(timeIntervalSince1970: 147600008), end: Date(timeIntervalSince1970: 147610008)))
    }
}
