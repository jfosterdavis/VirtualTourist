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
import CoreData

class TourMapViewController: CoreDataMapViewController, UIGestureRecognizerDelegate {
    
    
    /******************************************************/
    /******************* Properties **************/
    /******************************************************/
    //MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var models = [Pin]() //the model is an array of pins
    var appDelegate: AppDelegate!
    
    
    /******************************************************/
    /******************* Life Cycle **************/
    /******************************************************/
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        mapView.delegate = self
        
        //link the CoreDataMapViewController with the IBOutlet
        coreMapView = mapView
        
        //add tap recognition
        //adapted from http://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
        // http://stackoverflow.com/questions/30858360/adding-a-pin-annotation-to-a-map-view-on-a-long-press-in-swift
        let gestureRecognizer = VTLongPressGR(target: self, action: #selector(handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        
        setupFetchedResultsController()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        plotInitialPins()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithModel()
        dataCheck()
    }
    
    /******************************************************/
    /******************* Map Delegate **************/
    /******************************************************/
    //MARK: - Map Delegate
    
    func mapView(_ mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            
            pinView!.pinTintColor = UIColor.blue
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
            let photoTour = storyboard?.instantiateViewController(withIdentifier: "PhotoTourViewController") as! PhotoTourViewController
            let pin = view.annotation as! Pin
            photoTour.pin = pin
                        
            self.navigationController?.pushViewController(photoTour, animated: true)
           
        }
    }
    
    /******************************************************/
    /******************* Model Operations **************/
    /******************************************************/
    //MARK: - Model Operations
    
    func syncViewWithModel() {
        
    }
    
    func setupFetchedResultsController(){
        
        //set up stack and fetchrequest
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),NSSortDescriptor(key: "title", ascending: true)]
        
        // So far we have a search that will match ALL Pins.
        
        // Create the FetchedResultsController
        let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchedResultsController = fc
        
    }
    
    func dataCheck(){
        let Pins = fetchedResultsController!.fetchedObjects
        print("There are \(Pins!.count) Pins in the data model")
    }
    
    func fetchModelPins() -> [Pin] {
        return fetchedResultsController!.fetchedObjects as! [Pin]
    }
    
    func plotInitialPins() {
        mapView.addAnnotations(fetchModelPins())
    }
    
    /******************************************************/
    /******************* Navigation **************/
    /******************************************************/
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "PhotoTourViewController" {
            
            if let vtVC = segue.destination as? PhotoTourViewController {
                
                //TODO: see if I need to use this
            }
        }
    }
    
    /******************************************************/
    /******************* GestureHandlerDelegate **************/
    /******************************************************/
    //MARK: - GestureHandlerDelegate
    
    //adapted from http://stackoverflow.com/questions/34431459/ios-swift-how-to-add-pinpoint-to-map-on-touch-and-get-detailed-address-of-th
    func handleTap(gestureRecognizer: VTLongPressGR) {
        
        //only handle the start of this event to avoid tons of pins being dropped
        //http://stackoverflow.com/questions/3319591/uilongpressgesturerecognizer-gets-called-twice-when-pressing-down
        if (gestureRecognizer.state == UIGestureRecognizerState.began){
        
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
            
            // Add annotation:
//            let newPin = MKPointAnnotation()
//            newPin.coordinate = coordinate
//            newPin.title = "test"
            //TODO: Download geocode
            
            //TODO: Set title and subtitle
            
            //TODO: Store the pin to the model
            let newPin = Pin(title: "Untitled", latitude: coordinate.latitude, longitude: coordinate.longitude, subtitle: nil, context: fetchedResultsController!.managedObjectContext)
            print("Just created a new Pin: \(newPin)")
            
            mapView.addAnnotation(newPin)
            mapView.selectAnnotation(newPin, animated: true)
        }
    }
    
}
