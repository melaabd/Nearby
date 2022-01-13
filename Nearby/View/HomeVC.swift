//
//  HomeVC.swift
//  Nearby
//
//  Created by melaabd on 1/12/22.
//

import MapKit
import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var venuesMap: MKMapView!
    var homeVM:HomeVM?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseVM = homeVM
        setupMap()
        setAnnotations()
    }
    
    private func setupMap() {
        venuesMap.delegate = self
        venuesMap.setMapFocus(centerCoordinate: LocationManager.shared.location.coordinate, radiusInKm: 1)
    }
    
    /// map the list of venues and add thier annotations
    private func setAnnotations() {
        guard let vAnnotations = homeVM?.annotations else { return }
        onMain { [weak self] in
            self?.venuesMap.addAnnotations(vAnnotations)
        }
    }
    
    /// override delegate function for reload data
    override func reloadData() {
        onMain { [weak self] in
            self?.setAnnotations()
        }
    }
    
}


//MARK: - conform MKMapViewDelegate with HomeVC
extension HomeVC: MKMapViewDelegate {
    /// implement delegete to reload date when user change the bounds
    /// - Parameter mapView: MKMapView
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let radius = mapView.currentRadius()
        onGlobal { [weak self] in
            self?.homeVM?.loadVenues(lat: mapView.centerCoordinate.latitude, long: mapView.centerCoordinate.longitude, radius: radius)
        }
    }
    
    /// implement custom Reusable Annotation View with custom annotation
    /// - Parameters:
    ///   - mapView: MKMapView current
    ///   - annotation: MKAnnotation
    /// - Returns: MKAnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VAnnotation else { return nil }
        let identifier = "vannotation"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation,reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
