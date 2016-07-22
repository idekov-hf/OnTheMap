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
	
    // MARK: Actions
    
	@IBAction func loginButtonPressed(sender: UIButton) {
		
		guard textFieldsEmpty() else {
			print("Text fields are emtpy")
			return
		}
		
		let email = emailTextField.text!
		let password = passwordTextField.text!
		
		UdacityClient.sharedInstance().authenticateWithCredentials(email, password: password) { (success, errorString) in
			executeBlockOnMainQueue {
				if success {
					self.completeLogin()
				} else {
					self.displayError(errorString)
				}
			}
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
		loginButton.enabled = enabled
		
		// adjust login button alpha
		loginButton.alpha = enabled ? 1.0 : 0.5
	}
	
	private func displayError(errorString: String?) {
		// TODO: Check to see if it is possible to have nil as a title
		let alertController = UIAlertController(title: nil, message: errorString, preferredStyle: .Alert)
		let defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
		alertController.addAction(defaultAction)
		presentViewController(alertController, animated: true, completion: nil)
	}
	
}

// MARK: = LoginViewController (UITextField related code)

extension LoginViewController {
	
	// Check if both credential text fields are empty
	private func textFieldsEmpty() -> Bool {
		// TODO: Add more conditional cases for when only 1 text field is empty
		if emailTextField.text == "" && passwordTextField.text == "" {
			return false
		}
		return true
	}
}