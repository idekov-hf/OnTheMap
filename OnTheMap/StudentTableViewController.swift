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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
	
	// MARK: Fields
	
	weak var delegate: TabViewControllersDelegate?
	
	// MARK: Actions
    
	@IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
		delegate?.dismissTabBarController()
	}
	
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        
        setUIEnabled(false)
        
        ParseClient.sharedInstance().getStudentInformation { (error) in
            
            executeBlockOnMainQueue({
                
                if error == nil {
                    
                    self.tableView.reloadData()
                    self.setUIEnabled(true)
                }
            })
        }
    }
    
    // MARK: Helper Methods
    
    private func displayError(errorString: String?) {
        
        let alertController = UIAlertController(title: nil, message: errorString, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setUIEnabled(bool: Bool) {
        
        bool ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        
        refreshButton.enabled = bool
    }
}

// MARK: - StudentTableViewController (Table View Data Source Methods)

extension StudentTableViewController: UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
		// TODO: make sure the return statement below works
        return StudentModel.sharedInstance().students?.count ?? 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
		let identifier = "Cell"
		let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
		
        if let studentInfo = StudentModel.sharedInstance().students?[indexPath.row] {
            cell.textLabel?.text = studentInfo.firstName + " " + studentInfo.lastName
            cell.detailTextLabel?.text = studentInfo.mediaURL
            cell.imageView?.image = UIImage(named: "pin")
        }
		
		return cell
	}
}

// MARK: - StudentTableViewController (Table View Delegate Methods)

extension StudentTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let studentInfo = StudentModel.sharedInstance().students?[indexPath.row] {
            
            if let url = NSURL(string: studentInfo.mediaURL) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
}
