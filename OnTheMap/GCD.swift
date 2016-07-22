//
//  GCD.swift
//  OnTheMap
//
//  Created by Iavor V. Dekov on 7/22/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import Foundation

func executeBlockOnMainQueue(block: () -> Void) {
	dispatch_async(dispatch_get_main_queue()) {
		block()
	}
}