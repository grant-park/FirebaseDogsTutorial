//
//  CreateAccountViewController.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/7/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import Firebase
import UIKit

class CreateAccountViewController: UIViewController {

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var retypeField: UITextField!
    @IBAction func signUpPressed(sender: AnyObject) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let retype = retypeField.text
        if username != "" && email != "" && password != "" {
            print(email!)
            print(password!)
            FirebaseManager.firebaseManager.BASE_REF.createUser(email!, password: password!, withValueCompletionBlock: { (error, result) -> Void in
                if error != nil {
                    self.errorAlert("Error", message: error.localizedDescription)
                } else {
                    FirebaseManager.firebaseManager.BASE_REF.authUser(email!, password: password!, withCompletionBlock: { (error, authData) -> Void in
                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
                        FirebaseManager.firebaseManager.createAccount(authData.uid, user: user)
                        NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                        self.performSegueWithIdentifier("LoggedIn", sender: nil)
                    })
                }
            })
        } else if retype != password {
            errorAlert("Invalid", message: "Password fields do not match.")
        } else {
            errorAlert("Invalid", message: "Please fill out all fields.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
