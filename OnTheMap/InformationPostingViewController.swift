//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Iavor V. Dekov on 7/25/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Information Posting View Controller

class InformationPostingViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findOnMapButton: UIButton!
	@IBOutlet var submitLinkButton: UIButton!
	
	
	// MARK: Fields
	
	var studentInformation = StudentInformation()
	
	weak var delegate: InformationPostingControllerDelegate?
	
	// MARK: Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        let udacityInstance = UdacityClient.sharedInstance()
        
		self.studentInformation.firstName = udacityInstance.firstName!
		self.studentInformation.lastName = udacityInstance.lastName!
		self.studentInformation.uniqueKey = udacityInstance.accountID!
	}
    
    // MARK: Actions
    
	@IBAction func cancelButtonPressed(sender: UIButton) {
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
    @IBAction func findOnMapButtonPressed(sender: UIButton) {
		
        // Disable the UI while app is geocoding
        setUIEnabled(false)
        
		guard let locationText = locationTextField.text where locationText != "" else {
			displayError("Must Enter a Location.")
			return
		}
		
		studentInformation.mapString = locationText
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText) { (placemark, error) in
			
            self.setUIEnabled(true)
            
            if error != nil {
                
				self.displayError("Location not Found. Please Try Again.")
                
            } else {
				
                let coordinate = placemark![0].location!.coordinate
				
				self.studentInformation.latitude = coordinate.latitude
				self.studentInformation.longitude = coordinate.longitude
                
                var annotations = [MKPointAnnotation]()
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotations.append(annotation)
                
                self.firstView.hidden = true
                
                self.mapView.showAnnotations(annotations, animated: true)
            }
        }
    }
	
	@IBAction func submitButtonPressed(sender: UIButton) {
		
		if linkTextField.text! == "" {
			
			displayError("Must Enter a Link.")
			
		} else {
			
			studentInformation.mediaURL = linkTextField.text!
			
			setUIEnabled(false)
			
			ParseClient.sharedInstance().postStudentInformation(studentInformation) { (error) in
				
				executeBlockOnMainQueue({
					
					self.setUIEnabled(true)
					
					if let error = error {
						
						self.displayError(error)
						
					} else {
						
						self.dismissViewControllerAnimated(true, completion: { 
							self.delegate?.refreshData()
						})
					}
				})
			}
		}
	}
	
	// MARK: Helper Methods
	
	func setUIEnabled(bool: Bool) {
		
		bool ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
		
		submitLinkButton.enabled = bool
        
        findOnMapButton.enabled = bool
	}
}

// MARK: - InformationPostingViewController (UITextFieldDelegate)

extension InformationPostingViewController: UITextFieldDelegate {

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}

// MARK: - InformationPostingDelegate

protocol InformationPostingControllerDelegate: class {
	func refreshData()
}
