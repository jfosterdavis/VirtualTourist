//
//  PhotoTourViewController.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 10/5/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PhotoTourViewController: UIViewController,  MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var pin: Pin?
    
    /******************************************************/
    /******************* Life Cycle **************/
    /******************************************************/
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        mapView.delegate = self
        
        plotPin()
    }
    
    func plotPin(){
        if let pin = pin {
            mapView.addAnnotation(pin)
        }
    }
}
