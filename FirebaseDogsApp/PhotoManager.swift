//
//  PhotoManager.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/7/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import Foundation
import UIKit

class PhotoManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var aSender: UIViewController?
    var aImagePickerController: UIImagePickerController?
    var delegate: Caption? = nil
    
    init(sender: UIViewController, anImagePickerController: UIImagePickerController) {
        aSender = sender
        aImagePickerController = anImagePickerController
    }
    
    func showPhotoSourceSelection() {
        let alert = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        if UIImagePickerController.isCameraDeviceAvailable(.Rear) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default, handler: { (action) -> Void in
                self.aImagePickerController!.sourceType = .Camera
                self.aSender?.presentViewController(self.aImagePickerController!, animated: true, completion: nil)
            })
            alert.addAction(cameraAction)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) -> Void in
            self.aImagePickerController!.sourceType = .PhotoLibrary
            self.aSender?.presentViewController(self.aImagePickerController!, animated: true, completion: nil)
        }
        alert.addAction(photoLibraryAction)
        aSender?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        var caption: UITextField?
        let alert = UIAlertController(title: "Caption it!", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield: UITextField) -> Void in
            textfield.placeholder = "Some description..."
            caption = textfield
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { (alert) -> Void in
            //use protocol/delegate logic to send this back to asender? nah just pass it to asender lmao
            self.delegate?.getCaption(caption!.text!)
            self.aSender?.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(submitAction)
        aImagePickerController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        aSender?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
