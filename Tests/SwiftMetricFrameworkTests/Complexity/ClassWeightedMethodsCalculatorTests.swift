import Foundation
import XCTest
import SourceKittenFramework
@testable import SwiftMetric

class ClassWeightedMethodsCalculatorTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testCalculate() {
        let file = File(contents: "class A { func a() { if true { } if false { } }  func b() { } }")
        let structure = Structure(file: file)
        let classA = ClassFinder(structure.dictionary).find().first!

        let result = ClassWeightedMethodsCalculator(classA).calculate()

        XCTAssertEqual(result, 4)
    }
    
}
