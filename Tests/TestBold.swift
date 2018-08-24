import XCTest
@testable import MarkdownHero

class TestBold:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testParseBoldStars() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "**\(text)**"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(UIFont.systemFont(ofSize:self.parser.font.pointSize, weight:.heavy), parsedFont,
                               "Not bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseBoldUnderscore() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "__\(text)__"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(UIFont.systemFont(ofSize:self.parser.font.pointSize, weight:.heavy), parsedFont,
                               "Not bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
