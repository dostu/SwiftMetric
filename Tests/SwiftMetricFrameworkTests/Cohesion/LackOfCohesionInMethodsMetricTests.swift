import Foundation
import XCTest
@testable import SwiftMetric

class LackOfCohesionInMethodsMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(
            path: "A.swift",
            content: "class A { var a: String?; func methodA() { print(self.a); methodB(); } func methodB() { }; func methodC() { }; methodD() { print(a) }; }"
        )
        let files = [sourceFile1]
        let results = LackOfCohesionInMethodsMetric(files).measure()

        XCTAssertEqual(results.count, 1)

        let result1 = results[0]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 2)
    }
    
}
