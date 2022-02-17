//
//  MakeViewModel_Tests.swift
//  cars_demoTests
//
//  Created by Utsav Patel on 15/02/2022.
//

import XCTest
@testable import cars_demo

class MakeViewModel_Tests: XCTestCase {

    var viewModel: MakeViewModel?
    override func setUp() { }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func test_makeViewModel_call_api_success() {
        
        viewModel = MakeViewModel(apiService: EdmundsClient())
        let expectation1 = self.expectation(description: "EdmundsClient")

        viewModel?.reloadTableViewClosure = { () in
            expectation1.fulfill()
            XCTAssertNotEqual(self.viewModel!.numberOfCells, 0, "numberOfCells shoud not zero if data fetched")
        }
        viewModel?.initFetch()
        self.waitForExpectations(timeout: 20)
    }
    
    func test_makeViewModel_api_call_loading_state() {
        
        viewModel = MakeViewModel(apiService: EdmundsClient())
        let expectation1 = self.expectation(description: "EdmundsClient")
        
        viewModel?.reloadTableViewClosure = { () in
            expectation1.fulfill()
            XCTAssertFalse(self.viewModel!.isLoading, "isLoading must false after API call ends")
        }
        viewModel?.initFetch()
        XCTAssertTrue(self.viewModel!.isLoading, "isLoading must true after API call")
        self.waitForExpectations(timeout: 20)
    }
    
    func test_makeViewModel_call_api_fill_cell_model() {
        
        viewModel = MakeViewModel(apiService: EdmundsClient())
        let expectation1 = self.expectation(description: "EdmundsClient")
        
        viewModel?.reloadTableViewClosure = { () in
            expectation1.fulfill()
            XCTAssertNotEqual(self.viewModel!.numberOfCells, 0, "numberOfCells shoud not zero if data fetched and result found")
        }
        
        XCTAssertEqual(self.viewModel!.numberOfCells, 0, "numberOfCells must be Zero before api call")
        viewModel?.initFetch()
        self.waitForExpectations(timeout: 20)
    }
}
