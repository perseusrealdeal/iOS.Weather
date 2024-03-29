//
//  MainModuleFunctionalTests.swift
//  WeatherTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  See LICENSE for details. All rights reserved.
//

import XCTest
@testable import Weather

class MainModuleFunctionalTests: XCTestCase {

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }

    func test_viewController_loadView_called() {
        let sut = MainViewController.storyboardInstance()

        sut.loadViewIfNeeded()
    }
}
