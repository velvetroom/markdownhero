import XCTest
@testable import MarkdownHero

class TestsScaping:XCTestCase {
    private var parser:Hero!
    
    override func setUp() {
        parser = Hero()
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
