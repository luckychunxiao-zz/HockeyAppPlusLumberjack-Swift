//
//  ViewController.swift
//  HockeyAppPlusLumberjack-Swift
//
//  Created by HockeyAppSupporter on 16/01/2017.
//  Copyright © 2017 Chunxiao. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DDLogInfo("This is My view controller!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CrashClicked(_ sender: Any) {
        
        let arr:Array = ["1","2"]
        print(arr[2])
    }

}

