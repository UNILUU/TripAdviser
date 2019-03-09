//
//  TripAdvisorTests.swift
//  TripAdvisorTests
//
//  Created by  on 3/8/19.
//

import XCTest

@testable import TripAdvisor

class TripAdvisorTests: XCTestCase {
    var city : City!
    var values : [String]!
    override func setUp() {
        values = ["Paris", "France", "https://www.worldtravelguide.net/wp-content/uploads/2017/10/shu-EDITORIAL-France-Paris-Arc-de-Triomphe-491961382-Kuba-Barzycki-1440x823.jpg", "Paris is especially known for its museums and architectural landmarks"]
        city = City(values)
    }

    override func tearDown() {
        values = nil
        city = nil
    }

    func testExample() {
        XCTAssertEqual(city.name, "Paris")
        XCTAssertEqual(city.description, "Paris is especially known for its museums and architectural landmarks")
        XCTAssertEqual(city.contury, "France")
        XCTAssertEqual(city.imageURL, "https://www.worldtravelguide.net/wp-content/uploads/2017/10/shu-EDITORIAL-France-Paris-Arc-de-Triomphe-491961382-Kuba-Barzycki-1440x823.jpg")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
