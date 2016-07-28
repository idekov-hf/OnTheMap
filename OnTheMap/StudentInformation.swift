//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/23/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    // MARK: Properties
    
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mediaURL: String
	
	// Properties used for uploading student locations
	
	var uniqueKey: String
	var mapString: String
    
    // MARK: Initializers
    
    init(dictionary: [String: AnyObject]) {
        
        firstName = dictionary[ParseClient.ParseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.ParseKeys.LastName] as! String
        latitude = dictionary[ParseClient.ParseKeys.Latitude] as! Double
        longitude = dictionary[ParseClient.ParseKeys.Longitude] as! Double
        mediaURL = dictionary[ParseClient.ParseKeys.MediaURL] as! String
        uniqueKey = ""
        mapString = ""
    }
	
	init() {
		firstName = String()
		lastName = String()
		latitude = Double()
		longitude = Double()
		mediaURL = String()
        uniqueKey = String()
        mapString = String()
	}
    
    // Mark: Helpers
    
    static func studentsFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var students = [StudentInformation]()
        
        // iterate through array of dictionaries, each student is a dictionary
        for result in results {
            students.append(StudentInformation(dictionary: result))
        }
        
        return students
    }
	
}