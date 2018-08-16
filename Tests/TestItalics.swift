import XCTest
@testable import MarkdownHero

class TestItalics:XCTestCase {    
    func testParseItalicsUnderscore() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "_\(text)_"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitItalic)!.symbolicTraits, "Not italics")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseItalicsStar() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "*\(text)*"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitItalic)!.symbolicTraits, "Not italics")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
}
