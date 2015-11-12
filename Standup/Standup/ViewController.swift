//
//  ViewController.swift
//  Standup
//
//  Created by Mike Rooijackers on 19-10-15.
//  Copyright © 2015 SMIOS7 Healthkit. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            
            let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            
            //let todayViewControllerNav = UINavigationController(rootViewController: todayViewController)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = tabBarController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error != nil) {
            print(error.localizedDescription)
            return
        }
        
        if let userToken = result.token {
            //Get user access token
            let token:FBSDKAccessToken = result.token
            
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            let todayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TodayViewController") as! TodayViewController
            
            let todayViewControllerNav = UINavigationController(rootViewController: todayViewController)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = todayViewControllerNav
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user is logged out")
    }

}

