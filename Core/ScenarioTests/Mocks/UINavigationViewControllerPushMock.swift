//
//  UINavigationViewControllerPushMock.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit

class UINavigationViewControllerPushMock: UINavigationController {
    var lastPushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        lastPushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
