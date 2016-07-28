//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/23/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

// MARK: ParseClient (Convenience Methods)

extension ParseClient {
    
    func getStudentInformation(completionHandlerForStudentInfo: (error: NSError?) -> Void) {
        
        // Set parameters
        let parameters = [
            ParameterKeys.limit: ParameterValues.limit,
            ParameterKeys.order: ParameterValues.order
        ]
        
        // Get data
        taskForGETMethod(parameters) { (result, error) in
            
            if let error = error {
                
                completionHandlerForStudentInfo(error: error)
            } else {
                
                if let results = result[JSONResponseKeys.Results] as? [[String: AnyObject]] {
                    
                    let students = StudentInformation.studentsFromResults(results)
					let annotations = StudentModel.annotationsFromStudents(students)
                    // Save the results in a separate model class
                    self.studentModel.students = students
					self.studentModel.annotations = annotations
                    completionHandlerForStudentInfo(error: nil)
                    
                } else {
                    
                    completionHandlerForStudentInfo(error: NSError(domain: "getStudentInformation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentInformation"]))
                }
            }
        }
    }
	
	// MARK: POST a StudentLocation
	
	func postStudentInformation(studentInformation: StudentInformation, completionHandlerForStudenInformation: (error: String?) -> Void) {
		
		let method = Methods.PostStudentLocation
		let jsonBody = "{\"uniqueKey\": \"\(studentInformation.uniqueKey)\", \"firstName\": \"\(studentInformation.firstName)\", \"lastName\": \"\(studentInformation.lastName)\",\"mapString\": \"\(studentInformation.mapString)\", \"mediaURL\": \"\(studentInformation.mediaURL)\",\"latitude\": \(studentInformation.latitude), \"longitude\": \(studentInformation.longitude)}"
		
		taskForPOSTMethod(method, jsonBody: jsonBody) { (result, error) in
			
			if error != nil {
				
				print(error)
				completionHandlerForStudenInformation(error: "Post Failed: Please Try Again.")
				
			} else {
				
				completionHandlerForStudenInformation(error: nil)
			}
		}
	}
}