import Foundation
import XCTest
@testable import SwiftMetric

class LooseClassCohesionMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(
            path: "A.swift",
            content: "class A { let a: String; let b: String; let c: String; let d: String; public func methodA() { print(a) }; func methodB() { methodA(); print(c) }; func methodC() { print(d) }; private func methodD() { print(c); print(d) }; }"
        )
        let files = [sourceFile1]
        let results = LooseClassCohesionMetric(files).measure()

        XCTAssertEqual(results.count, 1)

        let result1 = results[0]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 1)
    }
    
}
