//
//  VAnnotation.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import MapKit

//MARK: - Custom Annotation for map
class VAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let discipline: String?
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String? {
        return locationName
    }
    
    init(venue: Venue) {
        
        self.title = venue.poi?.name
        self.locationName = venue.info
        self.discipline = venue.type
        self.coordinate = CLLocationCoordinate2D(latitude: venue.position?.lat ?? 0.0, longitude: venue.position?.lon ?? 0.0)
        
        super.init()
    }
}
