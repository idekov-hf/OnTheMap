//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/23/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

// MARK: ParseClient

class ParseClient {
    
    // MARK: Properties
    
    let session = NSURLSession.sharedSession()
    let studentModel = StudentModel.sharedInstance()
    
    // MARK: GET
    
    func taskForGETMethod(parameters: [String: String], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: createURLFromParameters(parameters))
        request.addValue(Constants.ParseApplicationID, forHTTPHeaderField: HTTPHeaders.ParseApplicationID)
        request.addValue(Constants.RestAPIKey, forHTTPHeaderField: HTTPHeaders.RestAPIKey)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            self.checkAndExtractDataWithCompletionHandler(data, response: response, error: error, completionHandlerForDataExtraction: completionHandlerForGET)
        }
		
        task.resume()
    }
	
	// MARK: POST
	
	func taskForPOSTMethod(method: String, jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) {
		
		let request = NSMutableURLRequest(URL: NSURL(string: method)!)
		request.HTTPMethod = "POST"
		request.addValue(Constants.ParseApplicationID, forHTTPHeaderField: HTTPHeaders.ParseApplicationID)
		request.addValue(Constants.RestAPIKey, forHTTPHeaderField: HTTPHeaders.RestAPIKey)
		request.addValue(HTTPHeaders.ApplicationJSON, forHTTPHeaderField: HTTPHeaders.ContentType)
		request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
		
		let task = session.dataTaskWithRequest(request) { (data, response, error) in
			
			self.checkAndExtractDataWithCompletionHandler(data, response: response, error: error, completionHandlerForDataExtraction: completionHandlerForPOST)
		}
		
		task.resume()
	}
	
	// MARK: Helper Methods
	
	func checkAndExtractDataWithCompletionHandler(data: NSData?, response: NSURLResponse?, error: NSError?, completionHandlerForDataExtraction: (result: AnyObject!, error: NSError?) -> Void) {
		
		// Used for handling errors
		func sendError(error: String) {
			print(error)
			let userInfo = [NSLocalizedDescriptionKey : error]
			completionHandlerForDataExtraction(result: nil, error: NSError(domain: "ParseClient", code: 1, userInfo: userInfo))
		}
		
		// Was there an error?
		guard error == nil else {
			sendError("There was an error with your request: \(error)")
			return
		}
		
		// Did the response have a successfull status code?
//		guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode < 300 else {
//			sendError("Request returned wrong statusCode")
//			return
//		}
		
		// Was there any data returned?
		guard let data = data else {
			sendError("No data was returned by the request!")
			return
		}
		
		// Parse the data and use the data (happens in completion handler)
		self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForDataExtraction)
	}
	
    // Returns usable Foundation object from raw JSON
    private func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    // Create URL from parameters
    func createURLFromParameters(parameters: [String: String]) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}