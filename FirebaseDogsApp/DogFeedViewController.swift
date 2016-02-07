//
//  DogFeedViewController.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/6/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import UIKit
import Firebase

class DogFeedViewController: UIViewController, Caption {
    @IBAction func addPost(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.imagePickerController = UIImagePickerController()
            self.photoManager = PhotoManager(sender: self, anImagePickerController: self.imagePickerController!)
            self.photoManager?.delegate = self
            self.imagePickerController!.delegate = self.photoManager
            self.photoManager?.showPhotoSourceSelection()
        }
    }
    @IBOutlet weak var aTableView: UITableView!
    var imagePickerController: UIImagePickerController?
    var photoManager: PhotoManager?
    var source: TableData?
    var dogs = [Dog]()
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.firebaseManager.DOG_REF.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snapshot in snapshots {
                    if let snapDictionary = snapshot.value as? Dictionary<String,AnyObject> {
                        let key = snapshot.key
                        let dog = Dog(key: key, dictionary: snapDictionary)
                        self.dogs.insert(dog, atIndex: 0)
                    }
                }
            }
            self.aTableView.dataSource = TableData(cells: self.dogs, cellIdentifier: "dogFeedCell", sender: self)
            self.aTableView.reloadData()
        })
    }
    func getCaption(caption: String) {
        print(caption)
        
    }
}
