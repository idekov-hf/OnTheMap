//
//  StudentModel.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/23/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation
import MapKit

class StudentModel {
    
    // MARK: Properties
    
    var students: [StudentInformation]?
	var annotations: [MKPointAnnotation]?
	
	// MARK: Helper
	
	static func annotationsFromStudents(students: [StudentInformation]) -> [MKPointAnnotation] {
		
		var annotations = [MKPointAnnotation]()
		
		for student in students {
			
			let lat = CLLocationDegrees(student.latitude)
			let long = CLLocationDegrees(student.longitude)
			
			// The lat and long are used to create a CLLocationCoordinates2D instance
			let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
			
			let first = student.firstName
			let last = student.lastName
			let mediaURL = student.mediaURL
			
			// Here we create the annotation and set its coordiate, title, and subtitle properties
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = "\(first) \(last)"
			annotation.subtitle = mediaURL
			
			annotations.append(annotation)
		}
		
		return annotations
	}
	    
    // MARK: Shared Instance
    
    class func sharedInstance() -> StudentModel {
        struct Singleton {
            static var sharedInstance = StudentModel()
        }
        return Singleton.sharedInstance
    }
}