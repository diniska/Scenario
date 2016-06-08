//
//  ScenarioList.swift
//  Scenario
//
//  Created by Denis Chaschin on 29.05.16.
//  Copyright © 2016 diniska. All rights reserved.
//

import UIKit

public struct ScenarioList {
    public typealias ScenarioName = String

    private var items: [ScenarioName: Scenario] = [:]
    private var parameters: [ScenarioName: ScenarioParameters] = [:]

    public subscript(name: ScenarioName) -> Scenario? {
        get {
            return items[name]
        }
        set {
            items[name] = newValue
        }
    }

    public func performScenario(with name: ScenarioName, from viewController: UIViewController, callback:ScenarioResultCallback) {
        guard let scenario = self[name]
            else { debugPrint("There is no scenario with name \(name) in scenario list"); return }

        let scenarioParameters = parameters[name]

        scenario.perfrom(from: viewController, with: scenarioParameters, callback: callback)
    }

    public mutating func addPerformer(performer: ScenarioPerformer, with name: ScenarioName) {
        self[name] = performer.scenario
        self.parameters[name] = performer.parameters
    }

    public struct ScenarioPerformer {
        public let scenario: Scenario
        public var parameters: ScenarioParameters?

        public init(scenario: Scenario) {
            self.scenario = scenario
        }
    }
}