//
//  ViewControllerPresentationMock.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit

class ViewControllerPresentationMock: UIViewController {

    var lastPresentedViewController: UIViewController?

    override func present(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        lastPresentedViewController = viewController
    }

}
