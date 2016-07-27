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
    
    // MARK: Actions
    
	@IBAction func cancelButtonPressed(sender: UIButton) {
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
    @IBAction func findOnMapButtonPressed(sender: UIButton) {
        
        firstView.hidden = true
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text!) { (placemark, error) in
            if let error = error {
                
                print(error)
                
            } else {
                
                print(placemark![0].location?.coordinate)
                let coordinate = placemark![0].location?.coordinate
                
                var annotations = [MKPointAnnotation]()
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate!
                annotations.append(annotation)
                
                self.mapView.showAnnotations(annotations, animated: true)
            }
        }
    }
}
