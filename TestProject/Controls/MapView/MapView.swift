//
//  MapView.swift
//  TestProject
//
//  Created by Henit Nathwani on 13/11/17.
//  Copyright © 2017 Henit Nathwani. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import YelpAPI


class MapView: MKMapView {
    
    //MARK: VARIABLES
    var arrayBusiness : [YLPBusiness] = []
    var businessSelectedHandler: BusinessSelectionHandler = nil
    
    //MARK: LIFE CYCLE
    override func awakeFromNib() {
        self.delegate = self
        self.mapType = .standard
        self.tintColor = UIColor.themeColor
        self.showsUserLocation = true
        
    }
}

//MARK: - MKMapViewDelegate METHODS
extension MapView : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var reuseId = ""
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        else {
            reuseId = "Pin"
            var pinView: MKPinAnnotationView? = self.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            }
            pinView?.pinTintColor = UIColor.themeColor
            pinView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = btn

            return pinView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard self.businessSelectedHandler != nil else {
            return
        }
        
        guard (view.annotation is Annotation) else {
            return
        }
        
        self.businessSelectedHandler!((view.annotation as! Annotation).businessToDisplay)
    }
    
}

//MARK:- Annotation
public class Annotation : NSObject, MKAnnotation {
    public var title: String?
    public var subtitle: String?
    var businessToDisplay: Business?
    
    fileprivate var cord : CLLocationCoordinate2D?
    public var coordinate: CLLocationCoordinate2D {
        get {
            return self.cord!
        }
    }

    init(withBusinessInfo objBusiness: Business) {
        self.businessToDisplay = objBusiness
        self.title = objBusiness.businessName
        self.subtitle = "\(BusinessDetailTitles.rating)\(String(format: "%g",objBusiness.businessRating))"
        self.cord = CLLocationCoordinate2D(latitude: objBusiness.latitude, longitude: objBusiness.longitude)
    }
}
