import XCTest
@testable import MarkdownHero

class TestEscaping:XCTestCase {
    private var parser:Hero!
    
    override func setUp() {
        parser = Hero()
    }
    
    func testEscaping() {
        XCTAssertEqual(" # *hello *world***", parser.parse(string:"``` # *hello *world***```").string)
    }
    
    func testWithPlain() {
        XCTAssertEqual("Bold # *hello *world***\nPlain",
                       parser.parse(string:"**Bold**``` # *hello *world***```\nPlain").string)
    }
    
    func testLists() {
        XCTAssertEqual("\n- list item", parser.parse(string:"```\n- list item```").string)
    }
}
