//
//  MyCheckOutTests.swift
//  MovieBookingAppTests
//
//  Created by MacBook Pro on 26/06/2022.
//

import XCTest
@testable import MovieBookingApp

class MyCheckOutTests: XCTestCase {

    var myCheckOut: MyCheckOut!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        myCheckOut = MyCheckOut.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        myCheckOut = nil
    }

    func test_row_withValue_returnData() throws {
        myCheckOut._row = "A"
        XCTAssertEqual(myCheckOut._row, "A")
    }
    
    func test_row_withEmpty_returnEmptyString() throws {
    
        XCTAssertEqual(myCheckOut._row, "")
    }

    func test_movieName_withValue_returnData() throws {
        myCheckOut._movieName = "Spiderman"
        XCTAssertEqual(myCheckOut._movieName, "Spiderman")
    }
    
    func test_movieName_withEmpty_returnEmptyString() throws {
        XCTAssertEqual(myCheckOut._movieName, "")
    }
    
    func test_cinemaName_withValue_returnData() throws {
        myCheckOut._cinemaName = "Cinema I"
        XCTAssertEqual(myCheckOut._cinemaName, "Cinema I")
        
    }
    
    func test_cinemaName_withEmpty_returnEmptyString() throws {
    
        XCTAssertEqual(myCheckOut._cinemaName, "")
    }
    
    func test_seatNumber_withValue_returnData() throws {
        myCheckOut._seatNumber = "A-1,A-2"
        XCTAssertEqual(myCheckOut._seatNumber, "A-1,A-2")
    }
    
    func test_seatNumber_withEmpty_returnEmptyString() throws {
    
        XCTAssertEqual(myCheckOut._seatNumber, "")
    }
    
    func test_totalPrice_withValue_returnData() throws {
        myCheckOut._totalPrice = 6
        XCTAssertEqual(myCheckOut._totalPrice, 6)
    }
    
    func test_totalPrice_withEmpty_returnReturnZero() throws {
    
        XCTAssertEqual(myCheckOut._totalPrice, 0)
    }

}
