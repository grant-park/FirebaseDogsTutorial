//
//  TableData.swift
//  FirebaseDogsApp
//
//  Created by Grant Hyun Park on 2/6/16.
//  Copyright © 2016 Grant Hyun Park. All rights reserved.
//

import Foundation
import UIKit

class TableData: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var cells: [AnyObject] = []
    var cellIdentifier: String?
    var sender: UIViewController?
    
    init(cells: [AnyObject], cellIdentifier: String!, sender: UIViewController!) {
        self.cells = cells
        self.cellIdentifier = cellIdentifier
        self.sender = sender
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dog = cells[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier!) as? DogFeedCell {
            cell.configure(dog as! Dog)
            return cell
        } else {
            return DogFeedCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
