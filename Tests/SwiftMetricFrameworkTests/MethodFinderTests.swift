import Foundation
import XCTest
import SourceKittenFramework
@testable import SwiftMetric

class MethodFinderTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testFind() {
        let file = File(contents: "class A { func a(arg: String) { } func b() { } }")
        let structure = Structure(file: file)
        let classStructure = structure.dictionary.substructure.first!.substructure

        let results = MethodFinder(classStructure).find()
        XCTAssertEqual(results.count, 2)

        let result1 = results[0]
        let result2 = results[1]
        XCTAssertEqual(result1.name, "a(arg:)")
        XCTAssertEqual(result2.name, "b()")
    }
    
}
