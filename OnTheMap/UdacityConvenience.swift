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
		
		getSessionID(email, password: password) { (success, sessionID, errorString) in
			if success {
				print(sessionID)
				self.sessionID = sessionID
			}
			
			completionHandlerForAuth(success: success, error: "Invalid Email or Password.")
		}
	}
	
	// MARK: Get Session ID Method (used when logging in)
	
	private func getSessionID(email: String, password: String, completionHandlerForSession: (success: Bool, sessionID: String?, errorString: String?) -> Void) {
		
		let jsonBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
		
		// Make the request
		taskForPOSTMethod(Methods.CreateSession, jsonBody: jsonBody) { (results, error) in
			
			// Send the desired value(s) to completion handler
			if let error = error {
				print(error)
				completionHandlerForSession(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
			} else {
				guard let sessionDictionary = results[JSONResponseKeys.Session] as? [String: AnyObject] else {
					print("Could not find key \(JSONResponseKeys.Session) in \(results)")
					return
				}
				if let sessionID = sessionDictionary[JSONResponseKeys.SessionID] as? String {
					completionHandlerForSession(success: true, sessionID: sessionID, errorString: nil)
				} else {
					print("Could not find \(JSONResponseKeys.SessionID) in \(results)")
					completionHandlerForSession(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
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
				
			} else {
				
				print(result)
			}
		}
	}
}