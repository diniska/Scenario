//
//  AppDelegate.swift
//  UberOAuth
//
//  Created by Denis Chaschin on 12.06.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit
import Scenario

let authorizationScenario = UberAuthorizeScenario()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        authorizationScenario.handleLoginRedirectFromUrl(url, sourceApplication: sourceApplication)
        return true
    }

}

