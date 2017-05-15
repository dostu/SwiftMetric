import Foundation
import XCTest
@testable import SwiftMetric

class AfferentCouplingMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure1() {
        let sourceFile1 = SourceFile(path: "A.swift", content: "class A { func a() { } }")
        let sourceFile2 = SourceFile(path: "B.swift", content: "class B { func b() { let anObj = A(param: 1); anObj.a() } }")
        let files = [sourceFile1, sourceFile2]
        let results = AfferentCouplingMetric(files).measure()

        XCTAssertEqual(results.count, 2)

        let result1 = results[0]
        let result2 = results[1]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 1)

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 0)
    }

    func testMeasure2() {
        let sourceFile1 = SourceFile(path: "A.swift", content: "class A { func a() { } }")
        let sourceFile2 = SourceFile(path: "B.swift", content: "class B { func b() { let anObj = A(); anObj.a() } }; class C { func c() { A().a(); B() } }")
        let files = [sourceFile1, sourceFile2]
        let results = AfferentCouplingMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]
        let result3 = results[2]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 2)

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 1)

        XCTAssertEqual(result3.className, "C")
        XCTAssertEqual(result3.value, 0)
    }
    
}
