//
//  AppDelegate.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-16.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      
      
        
        
        do{
            _ = try Realm()
           
        } catch {
            print("error initializing new dat \(error)")
        }
        
            
        
        // Override point for customization after application launch.
        
        
        return true
    }

  
    



}

