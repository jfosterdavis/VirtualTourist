//
//  TourMapViewController.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 9/29/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class TourMapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    
    /******************************************************/
    /******************* Properties **************/
    /******************************************************/
    //MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    /******************************************************/
    /******************* Life Cycle **************/
    /******************************************************/
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set delegates
        mapView.delegate = self
        
        //add tap recognition
        //adapted from http://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
        // http://stackoverflow.com/questions/30858360/adding-a-pin-annotation-to-a-map-view-on-a-long-press-in-swift
        let gestureRecognizer = VTLongPressGR(target: self, action: #selector(handleTap(gestureReconizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    /******************************************************/
    /******************* Map Delegate **************/
    /******************************************************/
    //MARK: - Map Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            
            pinView!.pinTintColor = UIColor.red
            pinView!.animatesDrop = true
            
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    //Adapted from http://stackoverflow.com/questions/38599534/how-to-make-map-pins-animate-drop-swift-2-2-ios-9
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
////        let annotations = self.mapView.annotations
////        self.mapView.removeAnnotations(annotations)
////        self.mapView.addAnnotations(annotations)
//    }
    
    /**
     This delegate method is implemented to respond to taps. It opens the system browser
     to the URL specified in the annotationViews subtitle property.
     */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            //TODO: segue to collection
           
            
        }
    }
    
    /******************************************************/
    /******************* GestureHandlerDelegate **************/
    /******************************************************/
    //MARK: - GestureHandlerDelegate
    
    //adapted from http://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
    func handleTap(gestureReconizer: VTLongPressGR) {
        
        //only handle the start of this event to avoid tons of pins being dropped
        //http://stackoverflow.com/questions/3319591/uilongpressgesturerecognizer-gets-called-twice-when-pressing-down
        if (gestureReconizer.state == UIGestureRecognizerState.began){
        
            let location = gestureReconizer.location(in: mapView)
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
            
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
}
