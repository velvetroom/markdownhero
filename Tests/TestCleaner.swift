import XCTest
@testable import MarkdownHero

class TestCleaner:XCTestCase {
    private var cleaner:Cleaner!
    
    override func setUp() {
        cleaner = Cleaner()
    }
    
    func testCleanMultipleSpaces() {
        XCTAssertEqual("hello world", cleaner.clean(string:"hello        world"))
    }
    
    func testCleanMultipleBlankLines() {
        XCTAssertEqual("hello\n\nworld", cleaner.clean(string:"hello\n\n\nworld"))
    }
    
    func testListsMinues() {
        XCTAssertEqual("\n• hello\n• world", cleaner.clean(string:"\n- hello\n- world"))
    }
    
    func testListsPluses() {
        XCTAssertEqual("\n• hello\n• world", cleaner.clean(string:"\n+ hello\n+ world"))
    }
    
    func testListsStars() {
        XCTAssertEqual("\n• hello\n• world", cleaner.clean(string:"\n* hello\n* world"))
    }
}
