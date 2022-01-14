//
//  EndPointTests.swift
//  NearbyTests
//
//  Created by melaabd on 1/14/22.
//

import XCTest
@testable import Nearby

class EndPointTests: XCTestCase {
    
    func testThreads() {
        
        let endpoint = EndPoint.venues(lat: 50.0, long: 50.0, radius: 100)
        XCTAssertEqual(endpoint.url.absoluteString, "https://api.tomtom.com/search/2/nearbySearch/.json?lat=50.0&lon=50.0&radius=100.0&key=zvv9U2NlIZ3bxmOHAZ7SQGntRRSpxOkH")
        
    }
}
