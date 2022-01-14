//
//  BaseViewModelTests.swift
//  NearbyTests
//
//  Created by melaabd on 1/14/22.
//

import XCTest
@testable import Nearby

class BaseViewModelTests: XCTestCase {

    var baseViewModel: BaseViewModel!
    
    override func setUp() {
        super.setUp()
        
        baseViewModel = BaseViewModel()
    }
    
    override func tearDown() {
        baseViewModel = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(baseViewModel, "The view model should not be nil.")
    }
    
    func testFunctionality() {
        
        // Convert NearbyVenues.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "NearbyVenues", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let nearbyVenues = try! JSONDecoder().decode(NearbyVenues.self, from: data)
        
        XCTAssertNotNil(nearbyVenues.venues)
        XCTAssertEqual(nearbyVenues.venues?.first?.id, "784009000135244")
        baseViewModel.prepareDataSource(venueList: nearbyVenues.venues ?? [])
        
        XCTAssertNotNil(baseViewModel.annotations)
        XCTAssertEqual(baseViewModel.annotations?.first?.title, nearbyVenues.venues?.first?.poi?.name)
    }
}

