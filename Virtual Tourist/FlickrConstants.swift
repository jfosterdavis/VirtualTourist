//
//  FlickrConstants.swift
//  Virtual Tourist
//
//  Derrived from work Created by Jarrod Parkes on 2/11/15.
//  Copyright (c) 2015 Jarrod Parkes. All rights reserved.
//
//  Further devlopment by Jacob Foster Davis in October 2016

// MARK: - ParseClient (Constants)

extension FlickrClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: API Keys
        static let ApiKey : String = Secrets.FlickrAPIKey
        static let RESTApiKey : String = Secrets.FlickrRESTAPIKey
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        
    }
    
    // MARK: Methods
    struct Methods {
        
        //MARK: StudentLocation
        static let StudentLocationGET = "/StudentLocation"
        static let StudentLocationPUT = "/StudentLocation/{id}"
        static let StudentLocationPOST = "/StudentLocation"
        
        
    }
    
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        
        static let Limit = "limit" //limit - (Number) specifies the maximum number of StudentLocation objects to return in the JSON response
        static let Skip = "skip" //skip - (Number) use this parameter with limit to paginate through results
        static let Order = "order" //order - (String) a comma-separate list of key names that specify the sorted order of the results.  Prefixing a key name with a negative sign reverses the order (default order is ascending)
        static let Where = "where" //where - (Parse Query) a SQL-like query allowing you to check if an object value matches some target value. Example: https://parse.udacity.com/parse/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%221234%22%7D the above URL is the escaped form of… https://parse.udacity.com/parse/classes/StudentLocation?where={"uniqueKey":"1234"}
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        struct StudentLocation {
            static let ObjectID = "objectId" //Description: an auto-generated id/key generated by Parse which uniquely identifies a StudentLocation
            static let UniqueKey = "uniqueKey" //Description: an extra (optional) key used to uniquely identify a StudentLocation; you should populate this value using your Udacity account id
            static let FirstName = "firstName" //Description: the first name of the student which matches their Udacity profile first name
            static let LastName = "lastName"  //Description: the last name of the student which matches their Udacity profile last name
            static let MapString = "mapString" //Description: the location string used for geocoding the student location
            static let MediaURL = "mediaURL" //Description: the URL provided by the student
            static let Latitude = "latitude" //Description: the latitude of the student location (ranges from -90 to 90)
            static let Longitude = "longitude" //Description: the longitude of the student location (ranges from -180 to 180)
            static let CreatedAt = "createdAt" //Description: the date when the student location was created
            static let UpdatedAt = "updatedAt" //Description: the date when the student location was last updated
            //static let ACL = "ACL" //Description: the Parse access and control list (ACL), i.e. permissions, for this StudentLocation entry
        }
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: StudentLocation
        struct Results {
            static let Results = "results" //this is the name of the key that contains the array of StudentInformation dictionaries
            static let ObjectID = "objectId" //Description: an auto-generated id/key generated by Parse which uniquely identifies a StudentLocation
            static let UniqueKey = "uniqueKey" //Description: an extra (optional) key used to uniquely identify a StudentLocation; you should populate this value using your Udacity account id
            static let FirstName = "firstName" //Description: the first name of the student which matches their Udacity profile first name
            static let LastName = "lastName"  //Description: the last name of the student which matches their Udacity profile last name
            static let MapString = "mapString" //Description: the location string used for geocoding the student location
            static let MediaURL = "mediaURL" //Description: the URL provided by the student
            static let Latitude = "latitude" //Description: the latitude of the student location (ranges from -90 to 90)
            static let Longitude = "longitude" //Description: the longitude of the student location (ranges from -180 to 180)
            static let CreatedAt = "createdAt" //Description: the date when the student location was created
            static let UpdatedAt = "updatedAt" //Description: the date when the student location was last updated
            //static let ACL = "ACL" //Description: the Parse access and control list (ACL), i.e. permissions, for this StudentLocation entry
        }
        
    }
}
