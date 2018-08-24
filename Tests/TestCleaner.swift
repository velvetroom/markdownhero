import XCTest
@testable import MarkdownHero

class TestCleaner:XCTestCase {
    private var cleaner:Cleaner!
    
    override func setUp() {
        super.setUp()
        cleaner = Cleaner()
    }
    
    func testCleanMultipleSpaces() {
        let cleaned = cleaner.clean(string:"hello        world")
        XCTAssertEqual(cleaned, "hello world", "Not clean")
    }
    
    func testCleanMultipleBlankLines() {
        let cleaned = cleaner.clean(string:"hello\n\n\nworld")
        XCTAssertEqual(cleaned, "hello\n\nworld", "Not clean")
    }
    
    func testListsMinues() {
        let cleaned = cleaner.clean(string:"\n- hello\n- world")
        XCTAssertEqual(cleaned, "\n• hello\n• world")
    }
    
    func testListsPluses() {
        let cleaned = cleaner.clean(string:"\n+ hello\n+ world")
        XCTAssertEqual(cleaned, "\n• hello\n• world")
    }
    
    func testListsStars() {
        let cleaned = cleaner.clean(string:"\n* hello\n* world")
        XCTAssertEqual(cleaned, "\n• hello\n• world")
    }
}
