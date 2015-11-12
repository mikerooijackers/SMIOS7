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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() == nil) {
            print("user is not logged in")
        } else {
            print("user is logged in")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

