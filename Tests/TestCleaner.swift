import XCTest
@testable import MarkdownHero

class TestCleaner:XCTestCase {
    func testCleanMultipleSpaces() {
        let cleaned:String = Cleaner().clean(string:"hello        world")
        XCTAssertEqual(cleaned, "hello world", "Not clean")
    }
    
    func testCleanMultipleBlankLines() {
        let cleaned:String = Cleaner().clean(string:"hello\n\n\n\nworld")
        XCTAssertEqual(cleaned, "hello\nworld", "Not clean")
    }
}
