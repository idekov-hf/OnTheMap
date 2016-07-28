//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Iavor V. Dekov on 7/25/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import UIKit
import MapKit

// MARK: - MapViewController

class MapViewController: UIViewController {
	
	// MARK: Outlets
	
	@IBOutlet var mapView: MKMapView!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	@IBOutlet var refreshButton: UIBarButtonItem!
	
	// MARK: Properties
	
	weak var delegate: TabViewControllersDelegate?
	
	// MARK: Lifecycle Methods
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		downloadStudentInformation()
	}
	
	// MARK: Actions
	
	@IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
		delegate?.dismissTabBarController()
	}
    
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
		
		downloadStudentInformation()
    }
	
	@IBAction func pinButtonPressed(sender: UIBarButtonItem) {
		
		let infoPostingController = storyboard?.instantiateViewControllerWithIdentifier("InformationPostingViewController") as! InformationPostingViewController
		infoPostingController.delegate = self
		presentViewController(infoPostingController, animated: true, completion: nil)
	}
	
	
	// MARK: Helper Methods
	
	private func downloadStudentInformation() {
		
		setUIEnabled(false)
		
		mapView.removeAnnotations(mapView.annotations)
		
		ParseClient.sharedInstance().getStudentInformation { (error) in
			
			executeBlockOnMainQueue {
				
				self.setUIEnabled(true)
				
				if error == nil {
					
					self.mapView.addAnnotations(StudentModel.sharedInstance().annotations!)
					
				} else {
					
					self.displayError("Download of Data Failed.")
				}
			}
		}
	}
	
	func setUIEnabled(bool: Bool) {
		
		bool ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
		
		refreshButton.enabled = bool
	}
	
	private func displayError(errorString: String?) {
		
		let alertController = UIAlertController(title: nil, message: errorString, preferredStyle: .Alert)
		let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		presentViewController(alertController, animated: true, completion: nil)
	}
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
	
	// MKMapViewDelegate methods referenced from PinSample App
	
	// Here we create a view with a "right callout accessory view". You might choose to look into other
	// decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
	// method in TableViewDataSource.
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		
		let reuseId = "pin"
		
		var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
		
		if pinView == nil {
			pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
			pinView!.canShowCallout = true
			pinView!.pinTintColor = UIColor.redColor()
			pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
		}
		else {
			pinView!.annotation = annotation
		}
		
		return pinView
	}
	
	
	// This delegate method is implemented to respond to taps. It opens the system browser
	// to the URL specified in the annotationViews subtitle property.
	func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		if control == view.rightCalloutAccessoryView {
			let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle!, url = NSURL(string: toOpen) {
				app.openURL(url)
			}
		}
	}
}

// MARK: - MapViewController (InformationPostingControllerDelegate)

extension MapViewController: InformationPostingControllerDelegate {
	
	func refreshData() {
		
		downloadStudentInformation()
	}
}

// MARK: - TabViewControllersDelegate Protocol

protocol TabViewControllersDelegate: class {
	func dismissTabBarController()
}
