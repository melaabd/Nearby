//
//  LocationManager.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import CoreLocation
import UIKit


typealias LocationCompletion = ((CLLocation) -> Void)

class LocationManager: NSObject {
    static let shared = LocationManager()
    private var manager =  CLLocationManager()
    private var updateLocation: LocationCompletion?
    var location = CLLocation(latitude: 52.37664554165847, longitude: 4.905933098890577) // default value
    
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    private func checkAuthorizationStatus() {
        let status = manager.authorizationStatus
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            updateLocation?(location)
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            manager.requestLocation()
        @unknown default:
            updateLocation?(location)
        }
    }
    
    func getUserLocation(completion: @escaping LocationCompletion) {
        checkAuthorizationStatus()
        updateLocation = completion
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            updateLocation?(location)
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        updateLocation?(location)
    }
}
