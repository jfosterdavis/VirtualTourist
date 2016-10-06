//
//  FlickrConvenience.swift
//  Virtual Tourist
//
//  Derrived from work Created by Jarrod Parkes on 2/11/15.
//  Copyright (c) 2015 Jarrod Parkes. All rights reserved.
//
//  Further devlopment by Jacob Foster Davis in August - September 2016

import UIKit
import Foundation

// MARK: - FlickrClient (Convenient Resource Methods)

extension FlickrClient {
    
    func getFlickrSearchNearLatLong(_ lat: Double, long: Double, radius: Double = 5.0, completionHandlerForGetFlickrSearchNearLatLong: @escaping (_ results: AnyObject?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters: [String:Any] = [
            FlickrClient.Constants.ParameterKeys.Method: FlickrClient.Constants.Methods.SearchPhotos,
            FlickrClient.Constants.ParameterKeys.Format: FlickrClient.Constants.ParameterValues.ResponseFormat,
            FlickrClient.Constants.ParameterKeys.NoJSONCallback: FlickrClient.Constants.ParameterValues.DisableJSONCallback,
            FlickrClient.Constants.MethodArgumentKeys.PhotosSearch.RadiusUnits: "mi"
        ]
        //add passed parameters to parameters dictionary
        //latitude
        parameters[FlickrClient.Constants.MethodArgumentKeys.PhotosSearch.Latitude] = lat
        //longitude
        parameters[FlickrClient.Constants.MethodArgumentKeys.PhotosSearch.Longitude] = long
        //radius
        parameters[FlickrClient.Constants.MethodArgumentKeys.PhotosSearch.Radius] = radius
        
        print("\nAttempting to get Student Locations with the following parameters: ")
        print(parameters)
        
        /* 2. Make the request */
        let _ = taskForGETMethod(parameters: parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForGetFlickrSearchNearLatLong(nil, error)
            } else {
                //json should have returned a A dictionary with a key of "results" that contains an array of dictionaries
                
                if let resultsArray = results?[FlickrClient.Constants.ResponseKeys.Photos] as? NSArray { //dig into the JSON response dictionary to get the array at key "photos"
                    
                    print("Unwrapped JSON response from getFlickrSearchNearLatLong:")
                    print (resultsArray)
//                    for locationDictionary in resultsArray { //step through each member of the "results" array
//                        if let locationDictionary = locationDictionary as? [String:AnyObject] { //ensure eacy dictionary matches the correct type
//                            
//                            //this is the beginning of a new try
//                            tryCount += 1
//                            
//                            if let newStudentInformationStruct = StudentInformation(fromDataSet: locationDictionary){ //attempt to initialize a new StudentInformationStruct from the dictionary
//                                
//                                //We have a new StudentInformation struct, so save it to the shared model
//                                StudentInformationsModel.sharedInstance.StudentInformations.append(newStudentInformationStruct)
//                                
//                                //sort the model.
//                                //adapted from https://www.hackingwithswift.com/example-code/arrays/how-to-sort-an-array-using-sort
//                                StudentInformationsModel.sharedInstance.StudentInformations.sort {
//                                    $0.createdAt! > $1.createdAt!
//                                }
//                                
//                                //this attempt was a success
//                                successCount += 1
//                            } else { //if the attempt to init a new StudentInformation struct returns nil, it was not successful
//                                print("\nDATA ERROR: Failed to initialize a new StudentInformation Struct")
//                                
//                                //this attempt was a failure
//                                failCount += 1
//                            }
//                            //print("\nHere is one new item from the array of objects:")
//                            //print(locationDictionary)
//                        } else {
//                            print("DATA ERROR: Array within the \"results\" dictionary does not match type [String:AnyObject]")
//                        }
//                        
//                    }
//                    print("\nThere are " + String(self.StudentInformations.count) + " Information Records stored.  getStudentLocations data pull Complete.")
                    completionHandlerForGetFlickrSearchNearLatLong(results, nil)
                } else {
                    print("\nDATA ERROR: Could not find \(FlickrClient.Constants.ResponseKeys.Photos) in \(results)")
                    completionHandlerForGetFlickrSearchNearLatLong(nil, NSError(domain: "getUserData parsing", code: 4, userInfo: [NSLocalizedDescriptionKey: "DATA ERROR: Failed to interpret data returned from Flickr server (getFlickrSearchNearLatLong)."]))
                }
            } // end of error check
        } // end of taskForGetMethod Closure
    } //end getFlickrSearchNearLatLong
}
