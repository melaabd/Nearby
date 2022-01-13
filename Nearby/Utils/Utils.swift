//
//  Utils.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import Foundation


/// short cut for calling main thread
/// - Parameters:
///   - after: `Double`
///   - execute: `()->()`
func onMain(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}

/// short cut for calling background thread
/// - Parameters:
///   - after: `Double`
///   - execute: `()->()`
func onGlobal(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}
