//
//  ScenarioListTests.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import XCTest
@testable import Scenario

private class SimpeScenario: Scenario {
    var lastParameters: ScenarioParameters?
    var lastCallback: ScenarioResulCallback?
    var lastViewController: UIViewController?

    private func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResulCallback?) {
        lastParameters = parameters
        lastCallback = callback
        lastViewController = viewController
    }
}

class ScenarioListTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testListSavesScenarioWithoutParametersAndCallback() {
        var list = ScenarioList()
        let name = "name"
        let scenario = SimpeScenario()
        list[name] = scenario
        XCTAssertTrue(scenario === list[name] as! AnyObject?)
    }

    func testListCalledScenarioWithoutParametersAndCallback() {
        var list = ScenarioList()
        let name = "name"
        let scenario = SimpeScenario()
        list[name] = scenario
        let viewController = UIViewController()
        list.performScenario(with: name, from: viewController)
        XCTAssertNil(scenario.lastCallback)
        XCTAssertNil(scenario.lastParameters)
        XCTAssertEqual(scenario.lastViewController, viewController)
    }

    func testScenarioPerformerAddsParametersToScenarioCall() {
        var list = ScenarioList()
        let name = "name"
        let viewController = UIViewController()
        let parametersKey = "x"
        let parametersValue = "y"
        let parameters: ScenarioParameters = [parametersKey: parametersValue]

        let scenario = SimpeScenario()
        list[name] = scenario
        var performer = ScenarioList.ScenarioPerformer(scenario: scenario)
        performer.parameters = parameters
        list.addPerformer(performer, with: name)

        list.performScenario(with: name, from: viewController)

        XCTAssertNotNil(scenario.lastParameters)
        XCTAssertEqual(scenario.lastParameters?[parametersKey] as? String, parametersValue)
        XCTAssertNil(scenario.lastCallback)
        XCTAssertEqual(scenario.lastViewController, viewController)
    }

    func testScenarioPerformerAddsCallbackToScenarioCall() {
        var list = ScenarioList()
        let name = "name"
        let viewController = UIViewController()
        var callbackCalled = false
        let callback: ScenarioResulCallback = {_ in callbackCalled = true }

        let scenario = SimpeScenario()
        list[name] = scenario
        var performer = ScenarioList.ScenarioPerformer(scenario: scenario)
        performer.callback = callback
        list.addPerformer(performer, with: name)

        list.performScenario(with: name, from: viewController)

        XCTAssertNil(scenario.lastParameters)
        XCTAssertNotNil(scenario.lastCallback)
        XCTAssertEqual(scenario.lastViewController, viewController)
        scenario.lastCallback?(result: [:])
        XCTAssertTrue(callbackCalled)
    }
}
