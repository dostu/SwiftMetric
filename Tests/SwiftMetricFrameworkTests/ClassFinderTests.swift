import Foundation
import XCTest
import SourceKittenFramework
@testable import SwiftMetric

class ClassFinderTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testFind() {
        let file = File(contents: "class A { func a() } class B { }")
        let structure = Structure(file: file)
        let fileStructure = structure.dictionary

        let results = ClassFinder(fileStructure).find()
        XCTAssertEqual(results.count, 2)

        let result1 = results[0]
        let result2 = results[1]
        XCTAssertEqual(result1.name, "A")
        XCTAssertEqual(result2.name, "B")
    }
    
}
