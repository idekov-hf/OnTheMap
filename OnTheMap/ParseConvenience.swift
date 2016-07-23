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
    
    func getStudentInformation(completionHandlerForStudentInfo: (studentInfo: [StudentInformation]) -> Void) {
        
        // Set parameters
        let parameters = [
            ParameterKeys.limit: ParameterValues.limit,
            ParameterKeys.order: ParameterValues.order
        ]
        let method = Methods.GETStudentLocations
        
        // Make network response
        taskForGETMethod(method, parameters: parameters) { (results) in
            
            
        }
        
        
        // Parse results
        
        
        // Call completion handler
        completionHandlerForStudentInfo(studentInfo: studentInfo)
    }
}