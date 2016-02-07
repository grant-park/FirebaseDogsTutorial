//
//  DogFeedCell.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/6/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import UIKit
import Firebase

class DogFeedCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postUser: UILabel!
    @IBOutlet weak var postVotes: UILabel!
    @IBOutlet weak var postLikeDislike: UIImageView!
    
    var dog: Dog!
    var aVote: Firebase!
    
    func configure(dog: Dog) {
        self.dog = dog
        
        self.postCaption.text = "\(dog.dogCaption)"
        self.postUser.text = dog.username
        self.postVotes.text = "\(dog.dogVotes)"
        
        aVote = FirebaseManager.firebaseManager.CURRENT_USER_REF.childByAppendingPath("dogVotes").childByAppendingPath(dog.dogKey)
        
        aVote.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let downVote = snapshot.value as? NSNull {
                print(downVote)
                self.postLikeDislike.image = UIImage(named: "downVote")
            } else {
                self.postLikeDislike.image = UIImage(named: "upVote")
            }
        })
        
        //image later...
    }
    
    func touchVote(sender: UITapGestureRecognizer) {
        aVote.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let downVote = snapshot.value as? NSNull {
                print(downVote)
                self.postLikeDislike.image = UIImage(named: "downVote")
                self.dog.addOrSubtractVote(true)
                self.aVote.setValue(true)
            } else {
                self.postLikeDislike.image = UIImage(named: "upVote")
                self.dog.addOrSubtractVote(false)
                self.aVote.removeValue()
            }
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let touch = UITapGestureRecognizer(target: self, action: "touchVote:")
        touch.numberOfTapsRequired = 1
        postLikeDislike.addGestureRecognizer(touch)
        postLikeDislike.userInteractionEnabled = true
    }
    
    
    
}
