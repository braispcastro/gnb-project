//
//  XCTestCase.swift
//  GNBProjectTests
//
//  Created by Brais Castro on 8/5/22.
//

import XCTest
import Nimble
@testable import GNBProject

class BaseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        setNimbleConfiguration()
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        setNimbleConfiguration()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    private func setNimbleConfiguration() {
        Nimble.AsyncDefaults.timeout = .seconds(10)
        Nimble.AsyncDefaults.pollInterval = .milliseconds(200)
    }
    
}

extension XCTestCase {
    
    func wait(until expectations: [XCTestExpectation]) {
        wait(for: expectations, timeout: 1.0)
    }
    
    func wait(for expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: 1.0)
    }
    
}
