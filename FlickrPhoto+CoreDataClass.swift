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
    
    convenience init(FlickrResult: FlickrPhotoResult, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entity(forEntityName: "FlickrPhoto", in: context) {
            self.init(entity: ent, insertInto: context)
            
            //using the FlickrPhotoResult, populate this object
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
        } else {
            fatalError("Unable to find Entity name! (FlickrPhoto)")
        }

    }
    
    /******************************************************/
    /*************///MARK: - General Functions
    /******************************************************/
    
    func checkAndDownloadImage() {
        if self.imageData == nil {
            flickrDownloadImageData()
        }
    }
    
    /******************************************************/
    /*************///MARK: - Network
    /******************************************************/
    
    func flickrDownloadImageData() {
        //download image data based on the URL
        
    }
}
