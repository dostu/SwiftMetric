import Foundation
import XCTest
@testable import SwiftMetric

class TightClassCohesionMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(
            path: "A.swift",
            content: "class A { var a: String?; public func methodA() { print(self.a) }; func methodB() { methodA() }; func methodC() { }; private func methodD() { }; }"
        )
        let files = [sourceFile1]
        let results = TightClassCohesionMetric(files).measure()

        XCTAssertEqual(results.count, 1)

        let result1 = results[0]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 1/3)
    }
    
}
