import Foundation
import XCTest
@testable import SwiftMetric

class CouplingBetweenObjectClassesMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(path: "A.swift", content: "class A { let b: B\n func a(d: D, e: E) { return d.c } }")
        let sourceFile2 = SourceFile(path: "B.swift", content: "class B { func b() { let anObj = A(param: 1); anObj.a() } }; class C { let a: A }")
        let files = [sourceFile1, sourceFile2]
        let results = CouplingBetweenObjectClassesMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 4)

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 1)
    }
    
}
