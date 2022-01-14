//
//  BaseViewModel.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import Foundation


// MARK: - Base View Model that have comman properties and functions for other view models
class BaseViewModel {
    
    weak var bindingDelegate:BindingVVMDelegate?
    var annotations:[VAnnotation]?
    
    /// load nearby venues for current location and with particuller radius
    /// - Parameters:
    ///   - lat: `Double`
    ///   - long: `Double`
    ///   - radius: `Double`
    func loadVenues(lat:Double, long:Double, radius:Double ) {
        NearbyVenues.getVenues(lat: lat, long: long, radius: radius) { [weak self] venues, errorMsg in
            guard errorMsg == nil else {
                self?.bindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            guard let venues = venues?.venues else { return }
            self?.prepareDataSource(venueList: venues)
        }
    }
    
    
    /// handle venues in annotations
    /// - Parameter venues: array of venues
    func prepareDataSource(venueList: [Venue]) {
        annotations = venueList.map{ VAnnotation(venue: $0) }
        bindingDelegate?.reloadData()
    }
}
