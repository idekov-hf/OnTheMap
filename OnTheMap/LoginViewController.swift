//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Iavor Dekov on 7/21/16.
//  Copyright © 2016 Iavor Dekov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	// MARK: Outlets
	
	@IBOutlet var loginButton: UIButton!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	
    // MARK: Actions
    
	@IBAction func loginButtonPressed(sender: UIButton) {
		
		// Check if either the email or password text fields are empty
		guard textFieldsEmpty() else {
			print("Text fields are emtpy")
			return
		}
		
		// Disable the UI (start spinning the activity indicator and disable the login button to prevent further taps while the network request is being processed)
		setUIEnabled(false)
		
		// Get String values of the user email and password from their respective textFields
		let email = emailTextField.text!
		let password = passwordTextField.text!
		
		// Authenticate the user, transition to the MainTabBarController if successfull or display an alert if unsuccessfull
		UdacityClient.sharedInstance().authenticateWithCredentials(email, password: password) { (success, errorString) in
			executeBlockOnMainQueue {
				if success {
					self.completeLogin()
				} else {
					self.setUIEnabled(true)
					self.displayError(errorString)
				}
			}
		}
	}
	
	@IBAction func signUpButtonPressed(sender: UIButton) {
		if let url = NSURL(string: "https://www.udacity.com/account/auth#!/signup") {
			UIApplication.sharedApplication().openURL(url)
		}
	}
	
	// MARK: Login
	
	private func completeLogin() {
		let controller = storyboard!.instantiateViewControllerWithIdentifier("MainTabBarController") as! UITabBarController
		presentViewController(controller, animated: true, completion: nil)
	}
}

// MARK: - LoginViewController (Configure UI)

extension LoginViewController {
	
	private func setUIEnabled(enabled: Bool) {
		
		// Start / stop spinning activity indicator
		if enabled {
			activityIndicator.stopAnimating()
		} else {
			activityIndicator.startAnimating()
		}
		
		// Toggle enabled property of the login button
		loginButton.enabled = enabled
		// Adjust login button alpha
		loginButton.alpha = enabled ? 1.0 : 0.5
	}
	
	private func displayError(errorString: String?) {
		
		let alertController = UIAlertController(title: nil, message: errorString, preferredStyle: .Alert)
		let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		presentViewController(alertController, animated: true, completion: nil)
	}
	
}

// MARK: - LoginViewController (UITextField related code)

extension LoginViewController {
	
	// Check if either credential text fields are empty
	private func textFieldsEmpty() -> Bool {
		// TODO: Add more conditional cases for when only 1 text field is empty
		if emailTextField.text == "" || passwordTextField.text == "" {
			displayError("Empty Email or Password.")
			return false
		}
		return true
	}
}