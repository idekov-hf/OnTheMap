//
//  StudentTableViewController.swift
//  OnTheMap
//
//  Created by Iavor V. Dekov on 7/22/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import UIKit

// MARK: - StudentTableViewController

class StudentTableViewController: UIViewController {

	// MARK: Outlets
	
	@IBOutlet var tableView: UITableView!
	
	
}

// MARK: - StudentTableViewController (Table View Data Source Methods)

extension StudentTableViewController: UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// TODO: return the correct number of rows in section
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
		
		// TODO: Configure cell view
		
		return cell
	}
}
