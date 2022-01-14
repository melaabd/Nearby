//
//  UtilsTests.swift
//  NearbyTests
//
//  Created by melaabd on 1/14/22.
//

import XCTest
@testable import Nearby

class UtilsTests: XCTestCase {
    
    func testThreads() {
        
        onMain {
            XCTAssertTrue(Thread.current.isMainThread)
        }
        
        onGlobal {
            XCTAssertFalse(Thread.current.isMainThread)
        }
        
    }
}
