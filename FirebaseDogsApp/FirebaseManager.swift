//
//  FirebaseManager.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/6/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let firebaseManager = FirebaseManager()
    
    private(set) var BASE_REF = Firebase(url: "\(BASE_URL)")
    private(set) var USER_REF = Firebase(url: "\(BASE_URL)/users")
    private(set) var DOG_REF = Firebase(url: "\(BASE_URL)/dogs")
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        return currentUser
    }
    
    func createAccount(userID: String, user: Dictionary<String, String>) {
        USER_REF.childByAppendingPath(userID).setValue(user)
    }
    
    func createDog(dog: Dictionary<String,AnyObject>) {
        DOG_REF.childByAutoId().setValue(dog)
    }
    
}
