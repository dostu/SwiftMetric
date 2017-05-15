import Foundation
import XCTest
import SwiftMetric

class LinesOfCodeTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testMeasure() {
        let sourceFile1 = SourceFile(
            path: "Books/Book.swift",
            content: "class Book {\n let a: String\n //comment\n}\n\n class BookTwo { \n   \n//comment\n }\n"
        )
        let sourceFile2 = SourceFile(path: "Article.swift", content: "struct Article {\n /* multi line comment \n let aInComment: String \n \n*/ \n func c() { } }")
        let files = [sourceFile1, sourceFile2]
        let results = LinesOfCodeMetric(files).measure()

        XCTAssertEqual(results.count, 3)

        let result1 = results[0]
        let result2 = results[1]
        let result3 = results[2]

        XCTAssertEqual(result1.className, "Book")
        XCTAssertEqual(result1.value, 2)
        XCTAssertEqual(result1.path, "Books/Book.swift")

        XCTAssertEqual(result2.className, "BookTwo")
        XCTAssertEqual(result2.value, 1)
        XCTAssertEqual(result2.path, "Books/Book.swift")

        XCTAssertEqual(result3.className, "Article")
        XCTAssertEqual(result3.value, 2)
        XCTAssertEqual(result3.path, "Article.swift")
    }
    
}
