//
//  Scenario.swift
//  Scenario
//
//  Created by Denis Chaschin on 28.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit

public typealias ScenarioParameters = [String: Any]
public typealias ScenarioResults = [String: Any]
public typealias ScenarioResultCallback = (result: ScenarioResults) -> ()

public protocol Scenario {
    func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResultCallback?)
}

public struct ScenarioStartedFromModalViewController: Scenario {
    public var createInitialViewController: (parameters: ScenarioParameters?, callback: ScenarioResultCallback) -> UIViewController?

    public func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResultCallback?) {
        let dismissCallback: ScenarioResultCallback = {[weak viewController] (result) in
            viewController?.dismissViewControllerAnimated(true) {
                callback?(result: result)
            }
        }
        guard let initialViewController = createInitialViewController(parameters: parameters, callback: dismissCallback)
            else { debugPrint("there is no possible view controller for such parameters"); return }
        viewController.presentViewController(initialViewController, animated: true, completion: nil)
    }
}

public struct ScenarioStartedFromNavigationViewController: Scenario {
    public var createInitialViewController: (parameters: ScenarioParameters?, callback: ScenarioResultCallback) -> UIViewController?

    public func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResultCallback?) {
        let presentationBlock: (initialViewController: UIViewController) -> ()
        let dismissBlock: () -> ()

        if let navigationController = viewController as? UINavigationController {
            presentationBlock = { (initialViewController) in
                navigationController.pushViewController(initialViewController, animated: true)
            }
            dismissBlock = { [weak navigationController] in
                navigationController?.popViewControllerAnimated(true)
            }
        } else if let navigationController = viewController.navigationController {
            presentationBlock = { (initialViewController) in
                navigationController.pushViewController(initialViewController, animated: true)
            }
            dismissBlock = { [weak navigationController] in
                navigationController?.popViewControllerAnimated(true)
            }
        } else {
            presentationBlock = { (initialViewController) in
                let navigationController = UINavigationController(rootViewController: initialViewController)
                viewController.presentViewController(navigationController, animated: true, completion: nil)
            }
            dismissBlock = { [weak viewController] in
                viewController?.dismissViewControllerAnimated(true, completion: nil)
            }
        }

        func resultDismissCallback(result: ScenarioResults) {
            dismissBlock()
            callback?(result: result)
        }

        guard let initialViewController = createInitialViewController(parameters: parameters, callback: resultDismissCallback)
            else { debugPrint("there is no possible view controller for such parameters"); return }

        if let navigationController = viewController as? UINavigationController {
            navigationController.pushViewController(initialViewController, animated: true)
        } else if let navigationController = viewController.navigationController {
            navigationController.pushViewController(initialViewController, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: initialViewController)
            viewController.presentViewController(navigationController, animated: true, completion: nil)
        }
    }
}
