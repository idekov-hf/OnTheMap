//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/23/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

// MARK: ParseClient (Constants)

extension ParseClient {
    
    // MARK: Constants
    
    struct Constants {
        
        // MARK: Keys
        
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RestAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: URLS
        
        static let APIScheme = "https"
        static let APIHost = "api.parse.com"
        static let APIPath = "/1/classes/StudentLocation"
    }
    
    // MARK: Headers
    
    struct HTTPHeaders {
        static let ParseApplicationID = "X-Parse-Application-Id"
        static let RestAPIKey = "X-Parse-REST-API-Key"
    }
    
    // MARK: JSON Response Keys
    
    struct JSONResponseKeys {
        static let Results = "results"
    }
    
    // MARK: Methods
    
    struct Methods {
        static let GETStudentLocations = "https://api.parse.com/1/classes/StudentLocation"
    }
    
    // MARK: Parameter Keys
    
    struct ParameterKeys {
        static let limit = "limit"
        static let order = "order"
    }
    
    // MARK: Parameter Values
    
    struct ParameterValues {
        static let limit = "100"
        static let order = "-updatedAt"
    }
}