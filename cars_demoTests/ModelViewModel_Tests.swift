//
//  ModelViewModel_Tests.swift
//  cars_demoTests
//
//  Created by Utsav Patel on 17/02/2022.
//

import XCTest
@testable import cars_demo

class ModelViewModel_Tests: XCTestCase {
    
    var makeViewModel: MakeViewModel?
    var modelViewModel: ModelViewModel?
    override func setUp() { }
    
    override func tearDown() {
        modelViewModel = nil
    }
    
    func test_modelViewModel_call_api_success() {
        
        let expectation1 = self.expectation(description: "makeViewModel_call_api_success")
        
        get_MakeViewModel {
            
            let makecell = self.makeViewModel!.getCellViewModel(at: IndexPath(row: 0, section: 0))
            self.modelViewModel = ModelViewModel(apiService: EdmundsClient(), make: makecell)
            
            self.modelViewModel?.reloadTableViewClosure = { () in
                expectation1.fulfill()
                XCTAssertNotEqual(self.modelViewModel!.numberOfCells, 0, "numberOfCells shoud not zero if data fetched")
            }
            self.modelViewModel?.initFetch()
        }
    }
    
    func test_modelViewModel_api_call_loading_state() {
        
        let expectation1 = self.expectation(description: "modelViewModel_api_call_loading_state")

        get_MakeViewModel {
            
            let makecell = self.makeViewModel!.getCellViewModel(at: IndexPath(row: 0, section: 0))
            self.modelViewModel = ModelViewModel(apiService: EdmundsClient(), make: makecell)
            
            self.modelViewModel?.reloadTableViewClosure = { () in
                expectation1.fulfill()
                XCTAssertFalse(self.modelViewModel!.isLoading, "isLoading must false after API call ends")
            }
            self.modelViewModel?.initFetch()
            XCTAssertTrue(self.modelViewModel!.isLoading, "isLoading must true after API call")
        }
    }
    
    func test_modelViewModel_call_api_fill_cell_model() {
        
        let expectation1 = self.expectation(description: "modelViewModel_call_api_fill_cell_model")
        
        get_MakeViewModel {
            
            let makecell = self.makeViewModel!.getCellViewModel(at: IndexPath(row: 0, section: 0))
            self.modelViewModel = ModelViewModel(apiService: EdmundsClient(), make: makecell)
            
            self.modelViewModel?.reloadTableViewClosure = { () in
                expectation1.fulfill()
                XCTAssertNotEqual(self.modelViewModel!.numberOfCells, 0, "numberOfCells shoud not zero if data fetched and data found")
            }
            XCTAssertEqual(self.modelViewModel!.numberOfCells, 0, "isLoading must true before API call")
            self.modelViewModel?.initFetch()
        }
    }
 
// Helpers
    func get_MakeViewModel(completeion: @escaping (() -> Void)) {
        makeViewModel = MakeViewModel(apiService: EdmundsClient())
        makeViewModel?.reloadTableViewClosure = { () in
            DispatchQueue.main.async {
                completeion()
            }
        }
        makeViewModel?.initFetch()
        self.waitForExpectations(timeout: 20)
    }
}
