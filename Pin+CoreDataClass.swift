//
//  Pin+CoreDataClass.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 9/30/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData
import MapKit

public class Pin: NSManagedObject, MKAnnotation {

    
    convenience init(title: String = "Unknown Location", latitude: Double, longitude: Double, subtitle: String?, context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "Pin", in: context) {
            self.init(entity: ent, insertInto: context)
            self.title = title
            self.latitude = latitude
            self.longitude = longitude
            self.creationDate = Date()
            if let givenSubtitle = subtitle{
                self.subtitle = givenSubtitle
            }
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
    // fact that needed to make this a delegate of MKAnnotation: http://juliusdanek.de/blog/coding/2015/07/14/persistent-pins-tutorial/
    /******************************************************/
    /******************* MKAnnotation **************/
    /******************************************************/
    //MARK: - MKAnnotation
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
