import XCTest
@testable import MarkdownHero

class TestItalics:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testParseItalicsUnderscore() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "_\(text)_"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits,
                               self.parser.font.fontDescriptor.withSymbolicTraits(.traitItalic)!.symbolicTraits,
                               "Not italics")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseItalicsStar() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "*\(text)*"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits,
                               self.parser.font.fontDescriptor.withSymbolicTraits(.traitItalic)!.symbolicTraits,
                               "Not italics")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
