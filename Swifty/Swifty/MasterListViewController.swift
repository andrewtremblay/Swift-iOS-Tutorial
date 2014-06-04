//
//  MasterListViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/3/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

//we can put class funcs in before our pre-class variables


class MasterListViewController: UITableViewController {
    var staticExampleObjects = ["First Example", "Second Example", "Third Example"]
    var dateObjects = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if AppDelegate.isIpad() {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // #pragma mark - Segues
    // #pragma mark - Table View
    
    //Two sections:
    //The first will be our unchanging, static examples,
    //The second will be the default NSDate row example
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    //
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String {
        //make sure you use the right titles
        return inStaticExampleSection(section) ? "Examples" : "Dates"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //make sure you use the relevant array sizes
        return inStaticExampleSection(section) ? staticExampleObjects.count : dateObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // you can move tableViewCell stuff into a function for better readablility
        if(inStaticExampleSection(indexPath.section)){
            return staticExampleCell(indexPath) //see Static Example Row Logic below
        }else {
            return dateCell(indexPath) //see Date Row Logic below
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !inStaticExampleSection(indexPath.section) // we do not want the example section to be editable, but eiditing in all other sections is fine
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(inStaticExampleSection(indexPath.section)){
            //THIS WILL NEVER BE DISPLAYED SINCE WE MADE THIS SECTION UNEDITABLE IN tableView:canEditRowAtIndexPath:
        }else {
            if editingStyle == .Delete {
                dateObjects.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else if editingStyle == .Insert {
                //Here you would create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. But this is an example and we aren't getting into that
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            if(inStaticExampleSection(indexPath.section)){
                let object = staticExampleObjects[indexPath.row]
                self.presentDetailViewController(object)
            }else {
                let object = dateObjects[indexPath.row]
                self.presentDetailViewController(object)
            }
        }
    }
    
    func presentDetailViewController(detailItem:AnyObject) {
        //default pushes new view controller
    }
    
    // #pragma mark - Static Example Row Logic
    
    func staticExampleCell(indexPath:NSIndexPath) -> UITableViewCell{
        var cellObject : AnyObject! = tableView.dequeueReusableCellWithIdentifier("ExampleTableViewCell")
        if(cellObject == nil){
           cellObject = NSBundle.mainBundle().loadNibNamed("ExampleTableViewCell", owner: self, options: nil)[0];
        }
        
        let cell = cellObject as UITableViewCell
        let object = staticExampleObjects[indexPath.row] as NSString
        cell.textLabel.text = object.description
        cell.textColor =  UIColor.brownColor() //change the color to show we can
        return cell
    }
    
    // #pragma mark - Date Row Logic
    
    func insertNewDateObject(sender: AnyObject) {
        if dateObjects == nil {
            dateObjects = NSMutableArray()
        }
        dateObjects.insertObject(NSDate.date(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 1)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func dateCell(indexPath:NSIndexPath) -> UITableViewCell{
        var cellObject : AnyObject! = tableView.dequeueReusableCellWithIdentifier("DateTableViewCell")
        if(cellObject == nil){
            cellObject = NSBundle.mainBundle().loadNibNamed("DateTableViewCell", owner: self, options: nil)[0];
        }
        
        let cell = cellObject as UITableViewCell
        let object = dateObjects[indexPath.row] as NSDate
        cell.textLabel.text = object.description
        return cell
    }
    
    
    // #pragma mark - Helper Functions
    
    //we needn't do this, but I prefer readability in my examples
    func inStaticExampleSection(section: Int) -> Bool {
        return section == 0
    }
    
}
