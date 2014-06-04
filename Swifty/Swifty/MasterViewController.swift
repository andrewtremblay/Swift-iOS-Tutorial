
//
//  MasterViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/2/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

//This is the ViewController that iPads will use regardless of iOS. See their storyboard for more info.
class MasterViewController: MasterListViewController {
    var detailViewController: DetailViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.endIndex-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func presentDetailViewController(detailItem:AnyObject) {
        //don't also call the super view (we're overriding)
        if let objectDate = detailItem as? NSDate {
            self.detailViewController!.detailItem = objectDate
        }
        
        if let objectString = detailItem as? String {
            self.detailViewController!.detailString = objectString
        }
    }

    // #pragma mark - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = dateObjects[indexPath.row] as NSDate
            ((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).detailItem = object
        }
    }
    

    
}

