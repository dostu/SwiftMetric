import Foundation
import XCTest
@testable import SwiftMetric

class WeightedMethodsPerClassMetricTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure() {
        let sourceFile1 = SourceFile(
            path: "A.swift",
            content: "class A { func a1() { if true { } }; func a2() { } }; class B { } }"
        )
        let sourceFile2 = SourceFile(path: "C.swift", content: "class C { func c() { } }")
        let files = [sourceFile1, sourceFile2]
        let results = WeightedMethodsPerClassMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]
        let result3 = results[2]

        XCTAssertEqual(result1.className, "A")
        XCTAssertEqual(result1.value, 3)
        XCTAssertEqual(result1.path, "A.swift")

        XCTAssertEqual(result2.className, "B")
        XCTAssertEqual(result2.value, 0)
        XCTAssertEqual(result2.path, "A.swift")

        XCTAssertEqual(result3.className, "C")
        XCTAssertEqual(result3.value, 1)
        XCTAssertEqual(result3.path, "C.swift")
    }
    
}
