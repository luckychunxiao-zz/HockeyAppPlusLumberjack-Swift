//
//  AppDelegate.swift
//  HockeyAppPlusLumberjack-Swift
//
//  Created by HockeyAppSupporter on 16/01/2017.
//  Copyright © 2017 Chunxiao. All rights reserved.
//

import UIKit
import HockeySDK
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BITHockeyManagerDelegate {

    var window: UIWindow?

    var fileLogger: DDFileLogger?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        fileLogger = DDFileLogger()
        fileLogger?.maximumFileSize = (1024 * 64)
        fileLogger?.logFileManager.maximumNumberOfLogFiles = 1
        fileLogger?.rollLogFile(withCompletion: nil)
        DDLog.add(fileLogger)
        
        
        print("One two three four five")
        
        BITHockeyManager.shared().configure(withIdentifier: "b1965e71958a4af2a52efba9b39e3c6b",delegate:self)
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
        
        
        
        // add Xcode console logger if not running in the App Store
        if BITHockeyManager.shared().appEnvironment != .appStore {
        
            DDLog.add(DDTTYLogger.sharedInstance())
            DDLog.add(DDASLLogger.sharedInstance())
        }
        
        
        
        return true
    }
    
    
    
   
    func applicationLog(for crashManager: BITCrashManager!) -> String! {
        
        let description:String = self.getLogFileContentWithMaxSize(maxSize: 5000)
        
        if description.lengthOfBytes(using: .utf8) > 0 {
            
            return description
            
        }else{
            
            return nil
        }
    }
    
    
    func getLogFileContentWithMaxSize(maxSize:NSInteger) -> String {
        
        var description: String = String.init()
        
        let sortedLogFileInfos:Array? = fileLogger?.logFileManager.sortedLogFileInfos
        
        for logFileInfo:DDLogFileInfo in (sortedLogFileInfos?.reversed())! {
            
            let logData:Data = FileManager.default.contents(atPath: logFileInfo.filePath)!
            
            if logData.count > 0 {
                
                let result:String = String(data: logData, encoding: .utf8)!
                
                description.append(result)
            }
            
        }
        
        if description.lengthOfBytes(using: .utf8)>maxSize {
            
            description = description.substring(to:description.index(description.startIndex, offsetBy: maxSize))
            
        }
        
        return description
    }

}

