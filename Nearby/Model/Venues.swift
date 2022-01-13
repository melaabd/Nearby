//
//  Venues.swift
//  Nearby
//
//  Created by melaabd on 1/13/22.
//

import Foundation

typealias VenuesAPICompletion = ((_ venues: NearbyVenues?, _ errorMsg:String?) -> Void)?

// MARK: - Venues
struct NearbyVenues: Codable {
    var venues: [Venue]?
    
    enum CodingKeys: String, CodingKey {
        case venues = "results"
    }
    
    static func getVenues(lat:Double, long:Double, radius: Double, completion: VenuesAPICompletion = nil) {
        /// endpoint instance with lat and long
        let endpoint = EndPoint.venues(lat: lat, long: long, radius: radius)
        
        /// get the task for venues weather
        let task = URLSession.shared.venuesTask(with: endpoint.url) { venuesList, errorMsg in
            completion?(venuesList, errorMsg)
        }
        task.resume()
    }
}

// MARK: - Result
struct Venue: Codable {
    var type, id: String?
    var score, dist: Double?
    var info: String?
    var poi: Poi?
    var address: Address?
    var position: GeoBias?
}

// MARK: - Address
struct Address: Codable {
    var freeformAddress: String?
}

// MARK: - GeoBias
struct GeoBias: Codable {
    var lat, lon: Double?
}

// MARK: - Poi
struct Poi: Codable {
    var name, phone: String?
}
