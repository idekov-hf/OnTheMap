//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/22/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

// MARK: - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: Methods
    struct Methods {
        static let CreateSession = "https://www.udacity.com/api/session"
    }
	
	// MARK: JSON Response Keys
	struct JSONResponseKeys {
		static let Session = "session"
		static let SessionID = "id"
	}
}