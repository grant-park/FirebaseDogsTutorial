//
//  LoginViewController.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/7/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginPressed(sender: AnyObject) {
        let email = usernameField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            FirebaseManager.firebaseManager.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                if error != nil {
                    self.errorAlert("Error", message: error.localizedDescription)
                } else {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    self.performSegueWithIdentifier("LoggedIn", sender: nil)
                }
            })
        } else {
            errorAlert("Invalid", message: "Please fill out all fields.")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && FirebaseManager.firebaseManager.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("AlreadyLoggedIn", sender: nil)
        }
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
