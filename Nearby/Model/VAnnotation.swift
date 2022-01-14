//
//  VAnnotation.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import MapKit
import Contacts

//MARK: - Custom Annotation for map
class VAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var locationName: String?
    var dist: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(venue: Venue) {
        
        title = venue.poi?.name
        locationName = venue.address?.municipalitySubdivision
        dist = "\(venue.dist?.rounded() ?? 0)"
        subtitle = venue.poi?.phone ?? venue.poi?.url ?? venue.address?.freeformAddress
        coordinate = CLLocationCoordinate2D(latitude: venue.position?.lat ?? 0.0, longitude: venue.position?.lon ?? 0.0)
        
        super.init()
    }
    
    /// parse anootation data into mapItem 
    var mapItem: MKMapItem? {
        guard let location = locationName else { return nil }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
