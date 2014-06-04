
//
//  MasterViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/2/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

//we can put class funcs in before our pre-class variables

class MasterViewController: MasterListViewController {
    var detailViewController: DetailViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addDateButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewDateObject:")
        self.navigationItem.rightBarButtonItem = addDateButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.endIndex-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // #pragma mark - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = dateObjects[indexPath.row] as NSDate
            ((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).detailItem = object
        }
    }

    override func presentDetailViewController(detailItem:AnyObject) {
        //don't also call the super view
        if let objectDate = detailItem as? NSDate {
            self.detailViewController!.detailItem = objectDate
        }
        
        if let objectString = detailItem as? String {
            self.detailViewController!.detailString = objectString
        }
    }

    
}

