//
//  UberAuthorizeScenario.swift
//  XUber
//
//  Created by Denis Chaschin on 07.06.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit
import UberKit

/**
 - Parameter parameters: [UberKitParameterKey: UberKit object]
 - Returns: [UberKitParameterKey: uber kit object, AccessTokenParameterKey: access token received from OAuth] or [ErrorParameterKey: NSError]
 */
class UberAuthorizeScenario: NSObject, Scenario {
    struct InputParameters {
        let uberClientID: String
        let uberClientSecret: String
        let currentApplicationDeeplinkId: String //without slashed, like "uber", not "uber://"
        let uberApplicationName: String //Current application name in uber developer console
    }

    static let InputParametersKey = "input"

    enum OutputParameters {
        case Success(uberKit: UberKit, accessToken: String)
        case Error(error: NSError)
    }

    static let OutputParametersKey = "output"

    private var uberKit: UberKit?
    private var callback: ScenarioResultCallback?

    private var inProgress: Bool {
        return uberKit != nil || callback != nil
    }

    func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResultCallback?) {
        guard inProgress == false
            else { debugPrint("Scenario already in progress."); return }

        guard let callback = callback
            else { return }

        guard let parameters = parameters
            else { debugPrint("There is no parameters at all. But parameters is necessary for this scenario"); return }
        guard let input = parameters[UberAuthorizeScenario.InputParametersKey] as? InputParameters
            else { debugPrint("parameters required to contains UberAuthorizeScenario.InputParameters object with UberKitParameterKey key."); return }

        let redirectURL = "\(input.currentApplicationDeeplinkId)://main"
        uberKit = UberKit(
            clientID: input.uberClientID,
            clientSecret: input.uberClientSecret,
            redirectURL: redirectURL,
            applicationName: input.uberApplicationName
        )
        self.callback = callback

        uberKit!.delegate = self
        uberKit!.startLogin()
    }

    /**
     * Don't forget to implement this method call from AppDelegate's method
     * func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
     */
    func handleLoginRedirectFromUrl(url: NSURL!, sourceApplication: String!) -> Bool {
        return uberKit?.handleLoginRedirectFromUrl(url, sourceApplication: sourceApplication) ?? false
    }

    private func clearData() {
        uberKit?.delegate = nil
        uberKit = nil
        callback = nil
    }
}

extension UberAuthorizeScenario: UberKitDelegate {
    func uberKit(uberKit: UberKit!, loginFailedWithError error: NSError!) {
        defer {
            clearData()
        }
        let result: [String: Any] = [UberAuthorizeScenario.OutputParametersKey : OutputParameters.Error(error: error)]
        callback?(result: result)
    }

    func uberKit(uberKit: UberKit!, didReceiveAccessToken accessToken: String!) {
        defer {
            clearData()
        }
        let outputParameters = OutputParameters.Success(uberKit: uberKit, accessToken: accessToken)
        let result: [String: Any] = [
            UberAuthorizeScenario.OutputParametersKey: outputParameters
        ]
        callback?(result: result)
    }
}