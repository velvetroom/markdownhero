import XCTest
@testable import MarkdownHero

class TestsScaping:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        parser = Parser()
    }
    
    func testScaping() {
        XCTAssertEqual(" # *hello *world***", parser.parse(string:"``` # *hello *world***```").string)
    }
    
    func testScapingWithPlain() {
        XCTAssertEqual("Bold # *hello *world***\nPlain",
                       parser.parse(string:"**Bold**``` # *hello *world***```\nPlain").string)
    }
    
    func testScapingLists() {
        XCTAssertEqual("\n- list item", parser.parse(string:"```\n- list item```").string)
    }
}
