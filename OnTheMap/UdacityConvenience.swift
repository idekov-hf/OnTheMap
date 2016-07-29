//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Iavor V. Dekov on 7/22/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

// MARK: - UdacityClient (Convenience Methods)

extension UdacityClient {
	
	// MARK: Authentication Method
	
	func authenticateWithCredentials(email: String, password: String, completionHandlerForAuth: (success: Bool, error: String?) -> Void) {
				
		getSessionID(email, password: password) { (success, sessionID, accountID, errorString) in
			if success {
				
				self.sessionID = sessionID
                self.accountID = accountID
                
                // Get user first name and last name after getting accountID
                self.getPublicUserData()
			}
			
			completionHandlerForAuth(success: success, error: errorString)
		}
	}
	
	// MARK: Get Session ID Method (used when logging in)
	
    private func getSessionID(email: String, password: String, completionHandlerForSession: (success: Bool, sessionID: String?, accountID: String?, errorString: String?) -> Void) {
		
		let jsonBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
		
		// Make the request
		taskForPOSTMethod(Methods.CreateSession, jsonBody: jsonBody) { (results, error) in
			
			// Send the desired value(s) to completion handler
			if let error = error {
				
				if error.code == -1009 {
					
					completionHandlerForSession(success: false, sessionID: nil, accountID: nil, errorString: "Internet Connection is Offline.")
					
				} else {
				
					completionHandlerForSession(success: false, sessionID: nil, accountID: nil, errorString: "Invalid Username or Password.")
				}
				
			} else {
                
				guard let sessionDictionary = results[JSONResponseKeys.Session] as? [String: AnyObject] else {
					print("Could not find key \(JSONResponseKeys.Session) in \(results)")
					return
				}
                
                guard let accountDictionary = results[JSONResponseKeys.Account] as? [String: AnyObject] else {
                    print("Could not find key \(JSONResponseKeys.Session) in \(results)")
                    return
                }
                
				if let sessionID = sessionDictionary[JSONResponseKeys.SessionID] as? String, accountID = accountDictionary[JSONResponseKeys.AccountKey] as? String {
					completionHandlerForSession(success: true, sessionID: sessionID, accountID: accountID, errorString: nil)
                    
				} else {
					print("Could not find \(JSONResponseKeys.SessionID) in \(results)")
					completionHandlerForSession(success: false, sessionID: nil, accountID: nil, errorString: "Login Failed (Session ID).")
				}
			}
		}
	}
	
	// MARK: Delete Session ID Method (used when logging out)
	
	func deleteSessionID() {
		
		let method = UdacityClient.Methods.DeleteSession
		
		taskForDELETEMethod(method) { (result, error) in
			
			if let error = error {
				
				print(error)
				
			} 
		}
	}
    
    // MARK: GET Public User Data
    
    func getPublicUserData() {
        
        var method = Methods.GetUserData
        method = method.stringByReplacingOccurrencesOfString("<user_id>", withString: accountID!)
        
        taskForGETMethod(method) { (result, error) in
            
            guard let userDictionary = result[JSONResponseKeys.User] as? [String: AnyObject] else {
                
                print("Failed to make userDictionary")
                return
            }
            
            if let firstName = userDictionary[JSONResponseKeys.FirstName] as? String, lastName = userDictionary[JSONResponseKeys.LastName] as? String {
                
                self.firstName = firstName
                self.lastName = lastName
            }
        }
    }
}