import XCTest
@testable import MarkdownHero

class TestLists:XCTestCase {
    private var parser:Hero!
    
    override func setUp() {
        parser = Hero()
    }
    
    func testList() {
        XCTAssertEqual("\n• item", parser.parse(string:"\n- item").string)
    }
    
    func testFirstElementMinus() {
        XCTAssertEqual("• A\n• B", parser.parse(string:"- A\n- B").string)
    }
    
    func testFirstElementPlus() {
        XCTAssertEqual("• A\n• B", parser.parse(string:"+ A\n- B").string)
    }
    
    func testFirstElementStar() {
        XCTAssertEqual("• A\n• B", parser.parse(string:"* A\n- B").string)
    }
}
