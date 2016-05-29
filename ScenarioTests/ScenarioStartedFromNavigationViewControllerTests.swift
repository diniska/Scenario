//
//  ScenarioStartedFromNavigationViewControllerTests.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import XCTest
@testable import Scenario

class ScenarioStartedFromNavigationViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testViewControllerShouldBeWrappedInNavigationViewControllerIfItIsNotInHierarchy() {
        let mainViewController = ViewControllerPresentationMock()
        let childViewController = UIViewController()

        let scenario = ScenarioStartedFromNavigationViewController { (parameters) -> UIViewController? in
            return childViewController
        }

        scenario.perfrom(from: mainViewController, with: nil, callback: nil)

        let lastPresentedViewController = mainViewController.lastPresentedViewController!

        XCTAssertTrue(lastPresentedViewController is UINavigationController)
        XCTAssertEqual((lastPresentedViewController as! UINavigationController).childViewControllers.first, childViewController)
    }

    func testViewControllerIsNotWrappedIfPresentedFromNavigationController() {
        let mainViewController = UINavigationController()
        let childViewController = UIViewController()

        let scenario = ScenarioStartedFromNavigationViewController { (parameters) -> UIViewController? in
            return childViewController
        }

        scenario.perfrom(from: mainViewController, with: nil, callback: nil)

        XCTAssertEqual(mainViewController.viewControllers.first, childViewController)
        XCTAssertEqual(mainViewController, childViewController.navigationController)
    }

    func testViewControllerIsNotWrappedIfPresentedInNavigationStack() {
        let mainViewController = UIViewController()
        let navigationViewController = UINavigationViewControllerPushMock(rootViewController: mainViewController)
        let childViewController = UIViewController()

        let scenario = ScenarioStartedFromNavigationViewController { (parameters) -> UIViewController? in
            return childViewController
        }

        scenario.perfrom(from: mainViewController, with: nil, callback: nil)

        XCTAssertEqual(navigationViewController.lastPushedViewController, childViewController)
    }

}
