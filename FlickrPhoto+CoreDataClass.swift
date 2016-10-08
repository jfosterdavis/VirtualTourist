//
//  FlickrPhoto+CoreDataClass.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 10/8/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import CoreData


public class FlickrPhoto: NSManagedObject {
    
    convenience init(FlickrResult: FlickrPhotoResult, entity: NSEntityDescription, insertInto context: NSManagedObjectContext!){
        self.init(entity: entity, insertInto: context)
        
        //usint the FlickrPhotoResult, populate this object
        if let farm = FlickrResult.farm,
           let height = FlickrResult.height,
           let id = FlickrResult.id,
            let isFamily = FlickrResult.isFamily,
            let isFriend = FlickrResult.isFriend,
            let isPublic = FlickrResult.isPublic,
            let owner = FlickrResult.owner,
            let secret = FlickrResult.secret,
            let server = FlickrResult.server,
            let title = FlickrResult.title,
            let url = FlickrResult.url,
            let width = FlickrResult.width {
            
            self.farm = Int64(farm)
            self.height = Int64(height)
            self.id = Int64(id)
            self.isFamily = isFamily
            self.isFriend = isFriend
            self.isPublic = isPublic
            self.owner = owner
            self.secret = secret
            self.server = Int64(server)
            self.title = title
            self.url = url
            self.width = Int64(width)
            
        } else {
            //TODO: throw an error because everything wasn't as expected
        }

    }
}
