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
		static let DeleteSession = "https://www.udacity.com/api/session"
        static let GetUserData = "https://www.udacity.com/api/users/<user_id>"
    }
	
	// MARK: JSON Response Keys
    
	struct JSONResponseKeys {
		static let Session = "session"
		static let SessionID = "id"
        static let Account = "account"
        static let AccountKey = "key"
        static let User = "user"
        static let FirstName = "first_name"
        static let LastName = "last_name"
	}
}