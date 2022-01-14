//
//  MapView.swift
//  Nearby
//
//  Created by melaabd on 1/13/22.
//

import MapKit

extension MKMapView {
    
    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
    }
    
    /// claculate current radius of the map
    /// - Returns: `Double` radius
    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        return centerLocation.distance(from: topCenterLocation)
    }
    
    /// set the radius ans center point for the map
    /// - Parameters:
    ///   - centerCoordinate: `CLLocationCoordinate2D`
    ///   - radius: `CLLocationDistance`
    func setMapFocus(centerCoordinate: CLLocationCoordinate2D, radiusInKm radius: CLLocationDistance) {
        let meters = radius * 2000
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: meters, longitudinalMeters: meters)
        setRegion(region, animated: false)
        setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region),animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: meters * 3)
        setCameraZoomRange(zoomRange, animated: true)
    }
}
