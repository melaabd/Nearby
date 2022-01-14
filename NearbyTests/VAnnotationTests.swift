//
//  VAnnotationTests.swift
//  NearbyTests
//
//  Created by melaabd on 1/14/22.
//

import XCTest
@testable import Nearby

class VAnnotationTests: XCTestCase {

    var vAnnotation: VAnnotation!
    
    override func setUp() {
        super.setUp()
        
        // Convert NearbyVenues.json to Data
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "NearbyVenues", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        // Provie any Codable struct
        let nearbyVenues = try! JSONDecoder().decode(NearbyVenues.self, from: data)
        
        vAnnotation = VAnnotation(venue: nearbyVenues.venues!.first!)
    }
    
    override func tearDown() {
        vAnnotation = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(vAnnotation, "The view model should not be nil.")
        XCTAssertNotNil(vAnnotation.mapItem)
        XCTAssertNotNil(vAnnotation.title)
        XCTAssertNotNil(vAnnotation.coordinate)
    }
    
    func testFunctionality() {
        
        XCTAssertEqual(vAnnotation.title, "Power Zone Express Fitness Centre")
        XCTAssertEqual(vAnnotation.mapItem?.name, "Power Zone Express Fitness Centre")
        
        XCTAssertEqual(vAnnotation.coordinate.latitude, 25.0929)
        XCTAssertEqual(vAnnotation.coordinate.longitude, 55.1768)

        
    }
}
