//
//  MasterListViewController.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/3/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit
//please note/appreciate the complete lack of required imports


//the list data is static so I'll just put it here
enum exampleObjects {
    //tuples!
    static var all = [
        (title: "First Example",  description: "Where we set the stage"),
        (title: "Second Example", description: " 😦 😮 😀 "),
        (title: "Third Example",  description: "Web Requests")];
    }

class MasterListViewController: UITableViewController {
    var dateObjects = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.isIpad() {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewDateObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //push in a new detail view controller via the navigation bar
    func presentDetailViewController(detailData:AnyObject) {
        let appDel :AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var newDetailVC : DetailViewController = appDel.newDetailViewController()
        //we can conditionally present data form here
        if let stringData = detailData as? String {
            newDetailVC.detailString = stringData
        }else {
            newDetailVC.detailItem = detailData
        }
        navigationController!.pushViewController(newDetailVC, animated: true)
        //
    }
    
    func presentEmojiViewController() {
        let appDel :AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var newEmojiVC : EmojiViewController = appDel.newEmojiViewController()
        navigationController!.pushViewController(newEmojiVC, animated: true)
    }

    func presentBaseExampleViewController(){
        let appDel :AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var newEmojiVC : EmojiViewController = appDel.newEmojiViewController()
        navigationController!.pushViewController(newEmojiVC, animated: true)
    }
    
    func presentWebcallViewController(){
        let appDel :AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var newEmojiVC : EmojiViewController = appDel.newEmojiViewController()
        navigationController!.pushViewController(newEmojiVC, animated: true)
    }
    

    // #pragma mark - Segues
    // #pragma mark - Table View
    
    //Two sections:
    //The first will be our unchanging, static examples,
    //The second will be the default NSDate row example
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    //make sure we use the right heights
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return inStaticExampleSection(indexPath.section) ? heightOfExampleCell() : heightOfDateCell()
    }
    
    //
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String {
        //make sure you use the right titles
        return inStaticExampleSection(section) ? "Examples" : "Dates"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //make sure you use the relevant array sizes
        return inStaticExampleSection(section) ? exampleObjects.all.count : dateObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // you can move tableViewCell stuff into a function for better readablility
        if(inStaticExampleSection(indexPath.section)){
            return staticExampleCell(indexPath) //see Static Example Row Logic below
        }else {
            return dateCell(indexPath) //see Date Row Logic below
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(inStaticExampleSection(indexPath.section)){
            if(exampleObjects.all[indexPath.row].title == "First Example"){
                self.presentBaseExampleViewController()
            }else if(exampleObjects.all[indexPath.row].title == "Second Example") {
                self.presentEmojiViewController()
            }else if(exampleObjects.all[indexPath.row].title == "Third Example") {
                self.presentWebcallViewController()
            }
        }else {
            self.presentDetailViewController(dateObjects[indexPath.row])
        }
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !inStaticExampleSection(indexPath.section) // we do not want the example section to be editable, but eiditing in all other sections is fine
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(inStaticExampleSection(indexPath.section)){
            //THIS WILL NEVER BE CALLED SINCE WE MADE THIS SECTION UNEDITABLE IN tableView:canEditRowAtIndexPath:
        }else {
            if editingStyle == .Delete {
                dateObjects.removeObjectAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else if editingStyle == .Insert {
                //Here you would create a new instance of the appropriate class, insert it into the array, and add a new row to the table view. But this is an example and we aren't getting into that
            }
        }
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
    
    // #pragma mark - Static Example Row Logic
    
    func staticExampleCell(indexPath:NSIndexPath) -> UITableViewCell{
        //First: reuse a view if we can
        var cellObject : AnyObject! = tableView.dequeueReusableCellWithIdentifier("ExampleTableViewCell")
        if(cellObject == nil){ //we have to load the object from a xib if we don't have it yet
            cellObject = NSBundle.mainBundle().loadNibNamed("ExampleTableViewCell", owner: self, options: nil)[0];
        }
        
        let cell:ExampleTableViewCell = cellObject as ExampleTableViewCell //note how we no longer need to import this, it's all in the same "module"
        let stringTitle = exampleObjects.all[indexPath.row].title as String //NOT NSString
        cell.setTitle(stringTitle)
        let stringDetail = exampleObjects.all[indexPath.row].description as String //NOT NSString
        cell.detailLabel.text = stringDetail
//        cell.titleLabel.textColor =  UIColor.brownColor() //change the color to show we can
        return cell
    }
    

    // #pragma mark - Helper Functions
    
    //we needn't do this, but I prefer readability in my examples
    func heightOfDateCell() -> CGFloat
    {
        return 44 //default height for a date table row
    }

    func heightOfExampleCell() -> CGFloat
    {
        return 60 //default height for an example table row
    }
    
    func inStaticExampleSection(section: Int) -> Bool {
        return section == 0
    }
    
}
