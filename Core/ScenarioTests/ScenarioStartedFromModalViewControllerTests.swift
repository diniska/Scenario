//
//  ScenarioStartedFromModalViewControllerTests.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import XCTest
@testable import Scenario

class ScenarioStartedFromModalViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewControllerAdddedToHierarchy() {
        let mainViewController = ViewControllerPresentationMock()
        let childViewController = UIViewController()

        let scenario = ScenarioStartedFromModalViewController { _,_  -> UIViewController? in
            return childViewController
        }

        scenario.perfrom(from: mainViewController, with: nil, callback: nil)

        XCTAssertEqual(mainViewController.lastPresentedViewController, childViewController)
    }
    
}
