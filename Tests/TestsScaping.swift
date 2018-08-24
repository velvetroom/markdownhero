import XCTest
@testable import MarkdownHero

class TestsScaping:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testScaping() {
        XCTAssertEqual(parser.parse(string:"``` # *hello *world***```").string, " # *hello *world***", "Not scaped")
    }
    
    func testScapingWithPlain() {
        XCTAssertEqual(parser.parse(string:"**Bold**``` # *hello *world***```\nPlain").string,
                       "Bold # *hello *world***\nPlain", "Not scaped")
    }
    
    func testScapingLists() {
        XCTAssertEqual(parser.parse(string:"```\n- list item```").string, "\n- list item", "Not scaped")
    }
}
