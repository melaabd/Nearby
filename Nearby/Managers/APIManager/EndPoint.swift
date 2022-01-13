//
//  EndPoint.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import Foundation

enum EndPoint {
    static let baseUrl = "https://api.tomtom.com/search/2/"
    static let apiKey = "zvv9U2NlIZ3bxmOHAZ7SQGntRRSpxOkH"
    
    case venues(lat:Double, long:Double, radius:Double)
    
    /// return endPoint's path `String`
    private var path : String {
        switch self {
        case .venues(let lat, let long, let radius):
            return "nearbySearch/.json?lat=\(lat)&lon=\(long)&radius=\(radius)"
        }
    }
    
    var url:URL {
        guard let url = URL(string: "\(EndPoint.baseUrl)\(path)&key=\(EndPoint.apiKey)") else {fatalError("Invalid Base URL.")}
        return url
    }
}
