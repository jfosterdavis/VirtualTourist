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
    
//    func postStudentLocation(_ postThisStudent : StudentInformation, completionHandlerForPostStudentLocation: @escaping (_ results: [String:String]?, _ error: NSError?) -> Void) {
//        
//        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        let parameters : [String:AnyObject]? = nil
//        
//        let mutableMethod: String = ParseClient.Methods.StudentLocationPOST
//        //mutableMethod = subtituteKeyInMethod(mutableMethod, key: "", value: "")! //There are no keys in this method, this is a placeholder
//        
//        guard postThisStudent.uniqueKey != nil else {
//            print("Unique Key is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.firstName != nil else {
//            print("First Name is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.lastName != nil else {
//            print("Last Name is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.mapString != nil else {
//            print("mapString is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.mediaURL != nil else {
//            print("mediaURL is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.latitude != nil else {
//            print("latitude is not set. Aborting.")
//            return
//        }
//        
//        guard postThisStudent.longitude != nil else {
//            print("longitude is not set. Aborting.")
//            return
//        }
//        
//        let jsonBody = "{\"\(ParseClient.JSONBodyKeys.StudentLocation.UniqueKey)\": \"\(postThisStudent.uniqueKey!)\", \"\(ParseClient.JSONBodyKeys.StudentLocation.FirstName)\": \"\(postThisStudent.firstName!)\", \"\(ParseClient.JSONBodyKeys.StudentLocation.LastName)\": \"\(postThisStudent.lastName!)\", \"\(ParseClient.JSONBodyKeys.StudentLocation.MapString)\": \"\(postThisStudent.mapString!)\", \"\(ParseClient.JSONBodyKeys.StudentLocation.MediaURL)\": \"\(postThisStudent.mediaURL!)\", \"\(ParseClient.JSONBodyKeys.StudentLocation.Latitude)\": \(postThisStudent.latitude!), \"\(ParseClient.JSONBodyKeys.StudentLocation.Longitude)\": \(postThisStudent.longitude!)}"
//        print("\nAttempting to post a StudentLocation with the following parameters: ")
//        print(parameters)
//        print(jsonBody)
//        
//        /* 2. Make the request */
//        let _ = taskForPOSTMethod(mutableMethod, parameters: parameters, jsonBody: jsonBody) { (results, error) in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                print(error)
//                completionHandlerForPostStudentLocation(nil, error)
//            } else {
//                
//                if let createdAtResult = results?[ParseClient.JSONResponseKeys.Results.CreatedAt] as? String {
//                    
//                    //we have the createdAt value
//                    if let objectIdResult = results?[ParseClient.JSONResponseKeys.Results.ObjectID] as? String {
//                        //we have the objectId value
//                        let postingResults = [ParseClient.JSONResponseKeys.Results.CreatedAt: createdAtResult, ParseClient.JSONResponseKeys.Results.ObjectID: objectIdResult]
//                        completionHandlerForPostStudentLocation(postingResults, nil)
//                    } else {
//                        print("\nDATA ERROR: Could not find \(ParseClient.JSONResponseKeys.Results.ObjectID) in \(results)")
//                        completionHandlerForPostStudentLocation(nil, NSError(domain: "getUserData parsing", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to interpret data returned from Parse server (postStudentLocation)."]))
//                    }
//                } else {
//                    print("\nDATA ERROR: Could not find \(ParseClient.JSONResponseKeys.Results.CreatedAt) in \(results)")
//                    completionHandlerForPostStudentLocation(nil, NSError(domain: "getUserData parsing", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to interpret data returned from Parse server (postStudentLocation)."]))
//                }
//            }
//        }
//    }
    
//    func getStudentLocations(_ limit : Int? = nil, skip: Int? = nil, order: String? = nil, completionHandlerForGetStudentLocations: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
//        
//        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        var parameters : [String: String] = [String: String]()
//        //check for each parameter and add to dictionary
//        //limit
//        if let limit = limit {
//            parameters[ParseClient.ParameterKeys.Limit] = String(limit)
//        }
//        //skip
//        if let skip = skip {
//            parameters[ParseClient.ParameterKeys.Skip] = String(skip)
//        }
//        //order
//        if let order = order {
//            parameters[ParseClient.ParameterKeys.Order] = order
//        }
//        
//        var passTheseParameters : [String: String]?
//        if parameters.isEmpty {
//            passTheseParameters = nil
//        } else {
//            passTheseParameters = parameters
//        }
//        
//        print("\nAttempting to get Student Locations with the following parameters: ")
//        print(parameters)
//        
//        /* 2. Make the request */
//        let _ = taskForGETMethod(ParseClient.Methods.StudentLocationGET, parameters: passTheseParameters as [String : AnyObject]?) { (results, error) in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                print(error)
//                completionHandlerForGetStudentLocations(false, error)
//            } else {
//                //json should have returned a A dictionary with a key of "results" that contains an array of dictionaries
//                
//                //At the end of the following if pyramid we will try to create a new StudentInformation struct and assign it values from the JSON results
//                var tryCount : Int = 0 //track tries
//                var successCount : Int = 0 //keep track of successes
//                var failCount : Int = 0  //track fails
//                
//                if let resultsArray = results?[ParseClient.JSONResponseKeys.Results.Results] as? NSArray { //dig into the JSON response dictionary to get the array at key "results"
//                    
//                    //print("Unwrapped JSON response from getStudentLocations:")
//                    //print (resultsArray)
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
//                    completionHandlerForGetStudentLocations(true, nil)
//                } else {
//                    print("\nDATA ERROR: Could not find \(ParseClient.JSONResponseKeys.Results.Results) in \(results)")
//                    completionHandlerForGetStudentLocations(false, NSError(domain: "getUserData parsing", code: 4, userInfo: [NSLocalizedDescriptionKey: "DATA ERROR: Failed to interpret data returned from Parse server (getStudentLocations)."]))
//                }
//                //report the results of this function to the log
//                print("\n")
//                print(String(tryCount) + " attempts to take data and initialize a new StudentLocation and store in shared model.")
//                print(String(successCount) + " of these StudentLocations attempts were successful.")
//                print(String(failCount) + " of these StudentLocations attempts failed.  These failures were not added to the shared model.")
//            }
//        }
//    }
}
