//
//  FlickrPhoto+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 10/8/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData
 

extension FlickrPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlickrPhoto> {
        return NSFetchRequest<FlickrPhoto>(entityName: "FlickrPhoto");
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var farm: Int16
    @NSManaged public var height: Int16
    @NSManaged public var id: Int16
    @NSManaged public var isFamily: Int16
    @NSManaged public var isFriend: Int16
    @NSManaged public var isPublic: Int16
    @NSManaged public var owner: String?
    @NSManaged public var secret: String?
    @NSManaged public var server: Int16
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var width: Int16
    @NSManaged public var pin: Pin?

}
