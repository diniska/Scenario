# Scenario
[![Travis](https://img.shields.io/travis/diniska/scenario.svg)](https://travis-ci.org/diniska/scenario)


##Abstract
There are many different user scenarios exist, such as authorization in some services, message sending, calling a taxi, photo editing, qr-code scanning, flight tickets searching etc.

Services provide API for integration with them usually. Some of them supply examples to show how to integrate it in your apps. But developers regulary need to write such API usage from the begining, or write using of third-party libraries.

Scenario framework aimed to simplify user scenarios integration in your apps. For example one service could supply your ready to use scenario, and you as a app developer could start such scenario just by pressing button. Or you can create some handy user scenarios and reuse them in your different applications.

Scenario framework using is simple enough. It's based on ```Scenario``` protocol which asks to provide one method:

```swift
func perfrom(from viewController: UIViewController, with parameters: ScenarioParameters?, callback: ScenarioResultCallback?)
```
It's beleived that user scenarios should be started from ```UIViewController```. User scenarios may want to have some parameters such as authorization token or color scheme to fit your app design better. Such parameters depends on each scenario and can be different. Also we suppose that you want to receive result of Scenario execution: if it is finished with error or was processed successfully, or maybe it returned some data that user filled in form. In such cases send callback handler to scenario and it would be called.

##Handy scenarios
Scenario framework provides some handy scenarios to simplify some situations handling like ```UINavigationController``` creating:


* ```ScenarioStartedFromNavigationViewController``` - checks if UINavigationController then scenario would be pushed to it or presented modally instead. It requires view controllers initializing implementation ```createInitialViewController```,
* ```ScenarioStartedFromModalViewController```- handy scenario template to start user scenario modally. Provide method to initialize view controller ```createInitialViewController``` to it.

##Simplifying Scenario start
**```ScenarioList```** - is a structure that could store all scenarios that you need. It's aim to let you setup different scenario parameters (such as social network tokens) at one time and start performing scenario at different time. 
Maybe you consider to setup parameters on app start. And after that you could start scenario whatever you want like:

```swift
scenarioList.performScenario(with: "Authorization", from: currentViewController)
```
without providing parameters again. Scenario's view controller created only when you start performing it so it doesn't take big amount of memory to store them.

##Development
This approach now in it's early ages, so some API usage could change. But we expect it to stay as simple as possible and to provide handy possibility to use different API's in your app.
You are really welcom to append your scenarios to collection in this repository by podspecs. Or append link to your repository that provide one to this readme file.