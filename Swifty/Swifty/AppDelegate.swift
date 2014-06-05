//
//  AppDelegate.swift
//  Swifty
//
//  Created by AndrewTremblay on 6/2/14.
//  Copyright (c) 2014 andrewTremblayLLC. All rights reserved.
//

import UIKit

//ALL MY EXTENSIONS ARE LISTED INSIDE APPDELEGATE
//most of them are just readability helpers
extension UIDevice {
    class func isIpad() -> Bool {
        return UIDevice.currentDevice().userInterfaceIdiom == .Pad
    }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var storyboard: UIStoryboard?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        //device suffixes ~iPad and ~iPhone don't work right now, in fact, a lot of .storyboard stuff is borked
        //Since I'm targeting iOS 7 and later, we can't use UISplitViewController everywhere (it only becomes universal in iOS 8)
        self.window = UIWindow() //window doesn't have an init with frame class, so we need to set that to the screen bounds in order to have touch
        self.window!.frame = UIScreen.mainScreen().bounds
        
        if UIDevice.isIpad() {
            self.storyboard = UIStoryboard(name: "Main~iPad", bundle: nil)
            self.window!.rootViewController = self.storyboard!.instantiateInitialViewController() as UISplitViewController
            let splitViewController = self.window!.rootViewController as UISplitViewController //odd how we need to keep casting
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.endIndex-1] as UINavigationController
            splitViewController.delegate = navigationController.topViewController as DetailViewController
        }else{
            self.storyboard = UIStoryboard(name: "Main~iPhone", bundle: nil)
            self.window!.rootViewController = self.storyboard!.instantiateInitialViewController() as UINavigationController
            //iPhones should just have a navigation controller as their root view
            // Other than that we don't really need to do anything special here
        }
        
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func newDetailViewController() -> DetailViewController {
        //make sure you set the Storyboard ID of the view controller if you want to repeat this behavior
        return self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as DetailViewController
    }
    
    func newEmojiViewController() -> EmojiViewController {
        return  EmojiViewController()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

