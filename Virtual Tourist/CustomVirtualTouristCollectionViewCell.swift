//
//  CustomVirtualTouristCollectionViewCell.swift
//  Virtual Tourist
//
//  Created by Jacob Foster Davis on 10/8/16.
//  Copyright © 2016 Zero Mu, LLC. All rights reserved.
//

import Foundation
import UIKit

class CustomVirtualTouristCollectionViewCell: UICollectionViewCell {
    
    //image
    @IBOutlet weak var imageView: UIImageView?
    
    //FlickrPhoto object
    var flickrPhoto: FlickrPhoto? {
        didSet {
            //try to set the label
            if let title = flickrPhoto?.title {
                self.label.text = title
            }
            
            //try to set the photo
            //adapted from http://stackoverflow.com/questions/32297704/convert-uiimage-to-nsdata-and-convert-back-to-uiimage-in-swift
            if let imageData = flickrPhoto?.imageData {
                self.imageView?.image = UIImage(data:imageData as Data,scale:1.0)
            } else {
                self.imageView?.image = nil
            }
            
        }
    }
    
    //label for updates
    @IBOutlet weak var label: UILabel!
    
    /** Spinning wheel to show user that network activity is in progress */
    weak var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    /******************************************************/
    /*************///MARK: - Activity Indicator
    /******************************************************/
    //adapted from http://stackoverflow.com/questions/33184968/adding-activity-loading-indicator-at-the-bottom-of-ucollectionview
   
    func startActivityIndicator() {
        self.activityIndicator!.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator!.stopAnimating()
    }
    
}
