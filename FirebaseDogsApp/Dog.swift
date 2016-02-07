//
//  Dog.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/6/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import Foundation
import Firebase

class Dog {
    private(set) var dogRef: Firebase?
    private(set) var dogKey: String?
    private(set) var dogCaption: String?
    private(set) var dogVotes: Int?
    private(set) var username: String?
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        if let votes = dictionary["dogVotes"] as? Int {
            self.dogVotes = votes
        }
        
        if let caption = dictionary["dogCaption"] as? String {
            self.dogCaption = caption
        }
        
        if let user = dictionary["username"] as? String {
            self.username = user
        } else {
            self.username = ""
        }
        
        self.dogRef = FirebaseManager.firebaseManager.DOG_REF.childByAppendingPath(key)
    }
    
    func addOrSubtractVote(add: Bool) {
        if add {
            dogVotes! += 1
        } else {
            dogVotes! -= 1
        }
        dogRef?.childByAppendingPath("votes").setValue(dogVotes)
    }
}

