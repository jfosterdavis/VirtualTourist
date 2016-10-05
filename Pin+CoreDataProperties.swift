//
//  Pin+CoreDataProperties.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 9/30/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var creationDate: Date

}
