import Foundation
import XCTest
@testable import SwiftMetric

class ResponseForClassMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure() {
        let sourceFile1 = SourceFile(
            path: "A.swift",
            content: "class A { func methodA() { let c = C(); c.methodC(); if true { c.methodD(); c.methodE() } }; func methodB() { C().methodE() }; }"
        )
        let files = [sourceFile1]
        let results = ResponseForClassMetric(files).measure()

        XCTAssertEqual(results.count, 1)

        let result1 = results[0]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 6)
    }
    
}
