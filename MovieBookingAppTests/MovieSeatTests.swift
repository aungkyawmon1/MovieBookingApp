//
//  MovieSeatTests.swift
//  MovieBookingAppTests
//
//  Created by MacBook Pro on 23/06/2022.
//

import XCTest
@testable import MovieBookingApp
import RxSwift

class MovieSeatTests: XCTestCase {
    
    var movieSeatModel: MockMovieSeatModel!
    var myCheckOut: MyCheckOut!
    var viewModel: MovieSeatViewModel!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieSeatModel = MockMovieSeatModel()
        myCheckOut = MyCheckOut.shared
        viewModel = MovieSeatViewModel(cinemaModel: movieSeatModel, myCheckOut: myCheckOut)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movieSeatModel = nil
        viewModel = nil
        disposeBag = nil
        myCheckOut = nil
    }

    func test_fetchMovieSeat_dataExist_returnData() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        viewModel.getSeatPlan()
        
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .success = state {
                    responseExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
    }


    func test_fetchMovieSeat_dataEmpty_shouldFail() throws {
        let responseExpectation = expectation(description: "wait for response")
        
        movieSeatModel.isSeatEmpty = true
        viewModel.getSeatPlan()
        viewModel.viewState
            .subscribe(onNext: { state in
                if case .failure(_) = state {
                    responseExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        wait(for: [responseExpectation], timeout: 5)
    }
    
    func test_movieSeat_selectSeats_shouldAddSeat() throws {
    
        let seat1 = SeatObject(id: 3, type: "available", seatName: "A-2", symbol: "A", price: 2)
        let seat2 = SeatObject(id: 5, type: "available", seatName: "A-5", symbol: "A", price: 5)
        
        self.viewModel.addSelectedMovieSeat(newSeat: seat1)
        self.viewModel.addSelectedMovieSeat(newSeat: seat2)
        
        XCTAssertEqual(viewModel.getSelectedMovieSeatsCount(), 2)
     
        
    }
    
    func test_movieSeat_unselectSeats_shouldRemoveSeat() throws {
        
        let seat1 = SeatObject(id: 3, type: "available", seatName: "A-2", symbol: "A", price: 2)
        let seat2 = SeatObject(id: 5, type: "available", seatName: "A-5", symbol: "A", price: 5)
        
        self.viewModel.addSelectedMovieSeat(newSeat: seat1)
        self.viewModel.addSelectedMovieSeat(newSeat: seat2)
        
        self.viewModel.removeSelectedMovieSeat(seat: seat2)
        XCTAssertEqual(viewModel.getSelectedMovieSeatsCount(), 1)
        
    }
    
    func test_movieSeats_updateUIElements_shouldUpdateValue() throws {
        let seat1 = SeatObject(id: 3, type: "available", seatName: "A-2", symbol: "A", price: 2)
        let seat2 = SeatObject(id: 5, type: "available", seatName: "A-5", symbol: "A", price: 5)
        
        viewModel.addSelectedMovieSeat(newSeat: seat1)
        viewModel.addSelectedMovieSeat(newSeat: seat2)
        viewModel.updateElements()
        XCTAssertEqual(viewModel.totalTicketPrice, 7)
        
    }
    
  
    func test_movieSeats_setMyCheckOut_shouldSuccessData() throws {
        MyCheckOut.shared._movieName = "Spider Man 2"
        MyCheckOut.shared._cinemaName = "Cinema I"
        MyCheckOut.shared._bookingDate = "2022-01-23"
        MyCheckOut.shared._cinemaTime = "9:30 AM"
        XCTAssertEqual(viewModel.movieName, "Spider Man 2")
        XCTAssertEqual(viewModel.cinemaName, "Cinema I")
        XCTAssertEqual(viewModel.getDateAndTime(), "Sun Jan 23 2022, 9:30 AM")
    }
    
    
}
