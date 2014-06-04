//
//  DetailViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/2/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISplitViewControllerDelegate {

    @IBOutlet var detailDescriptionLabel: UILabel
    var masterPopoverController: UIPopoverController? = nil

    //we can either set the detailitem and let the Vc take care of it, or we can adjust the string directly
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            if let detail: AnyObject = self.detailItem {
                self.detailString = detail.description
            }
            if self.masterPopoverController != nil {
                self.masterPopoverController!.dismissPopoverAnimated(true)
            }
        }
    }

    var detailString: String? {
        didSet {
            // Update the view.
            self.configureViewForDetailString()
            if self.masterPopoverController != nil {
                self.masterPopoverController!.dismissPopoverAnimated(true)
            }
        }
    }
    
    func configureViewForDetailString() {
        // Update the user interface for the detail item.
        if let detail: String = self.detailString {
            if let label = self.detailDescriptionLabel {
                label.text = detail
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        self.configureViewForDetailString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // #pragma mark - Split view
    func splitViewController(splitController: UISplitViewController, willHideViewController viewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController popoverController: UIPopoverController) {
        barButtonItem.title = "Master" // NSLocalizedString(@"Master", @"Master")
        self.navigationItem.setLeftBarButtonItem(barButtonItem, animated: true)
        self.masterPopoverController = popoverController
    }

    func splitViewController(splitController: UISplitViewController, willShowViewController viewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.masterPopoverController = nil
    }
    func splitViewController(splitController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return true
    }

}

