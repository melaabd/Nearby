//
//  HomeVMTests.swift
//  NearbyTests
//
//  Created by melaabd on 1/14/22.
//



import XCTest
@testable import Nearby

class HomeVMTests: XCTestCase {
    
    func testFunctionality() {
        
        // Convert NearbyVenues.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "NearbyVenues", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        // Provie any Codable struct
        let nearbyVenues = try! JSONDecoder().decode(NearbyVenues.self, from: data)
        
        let homeVM = HomeVM(places: nil)
        XCTAssertNotNil(homeVM)
        homeVM.prepareDataSource(venueList: nearbyVenues.venues!)
        XCTAssertNotNil(homeVM.annotations)
        XCTAssertEqual(homeVM.annotations?.first?.title, nearbyVenues.venues?.first?.poi?.name)
    }
}
