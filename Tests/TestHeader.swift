import XCTest
@testable import MarkdownHero

class TestHeader:XCTestCase {
    func testH1() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "# \(text)"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitBold)!.symbolicTraits, "Not bold")
                XCTAssertGreaterThan(parsedFont.pointSize, parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testH2() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "## \(text)"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitBold)!.symbolicTraits, "Not bold")
                XCTAssertGreaterThan(parsedFont.pointSize, parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testH3() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "### \(text)"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitBold)!.symbolicTraits, "Not bold")
                XCTAssertGreaterThan(parsedFont.pointSize, parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testHeaderAndPlain() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Parser = Parser()
        parser.parse(string:"# hello world\nlorem ipsum") { (result:NSAttributedString) in
            XCTAssertEqual(result.string, "hello world\nlorem ipsum", "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:13, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.symbolicTraits,
                               "Not plain")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
}
