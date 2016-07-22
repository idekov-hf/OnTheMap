//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/22/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

// MARK: - UdacityClient

class UdacityClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = NSURLSession.sharedSession()
    
    // authentication state
    var sessionID: String? = nil
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: POST
    
    func taskForPOSTMethod(method: String, jsonBody: String, completionHandlerForPost: (result: AnyObject!, error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: method)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            <#code#>
        }
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}