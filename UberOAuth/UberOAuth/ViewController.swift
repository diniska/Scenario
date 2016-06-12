//
//  ViewController.swift
//  UberOAuth
//
//  Created by Denis Chaschin on 12.06.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func performAuthorizationInUber(sender: AnyObject) {

        let parameters = UberAuthorizeScenario.InputParameters(
            uberClientID: "YOUR_CLIENT_ID",
            uberClientSecret: "YOUR_CLIENT_SECRET",
            currentApplicationDeeplinkId: "your_app_deep_link_id",
            uberApplicationName: "YOUR_APP_NAME_IN_UBER_DEVELOPER_CONSOLE"
        )
        authorizationScenario.perfrom(from: self, with: [UberAuthorizeScenario.InputParametersKey: parameters]) { (result) in
            debugPrint(result)
        }
    }
}

