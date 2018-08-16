import XCTest
@testable import MarkdownHero

class TestMixed:XCTestCase {
    func testParseItalicBoldStars() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "***\(text)***"
        let parser:Implementation = Implementation()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits(
                        [UIFontDescriptor.SymbolicTraits.traitItalic,
                         UIFontDescriptor.SymbolicTraits.traitBold]))!.symbolicTraits, "Not italic bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseItalicBoldUnderscores() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "___\(text)___"
        let parser:Implementation = Implementation()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits(
                        [UIFontDescriptor.SymbolicTraits.traitItalic,
                         UIFontDescriptor.SymbolicTraits.traitBold]))!.symbolicTraits, "Not italic bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseItalicBoldMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "_**\(text)**_"
        let parser:Implementation = Implementation()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits(
                        [UIFontDescriptor.SymbolicTraits.traitBold,
                         UIFontDescriptor.SymbolicTraits.traitItalic]))!.symbolicTraits, "Not italic bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseBoldItalicMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "**_\(text)_**"
        let parser:Implementation = Implementation()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits(
                        [UIFontDescriptor.SymbolicTraits.traitItalic,
                         UIFontDescriptor.SymbolicTraits.traitBold]))!.symbolicTraits, "Not bold italic")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Implementation = Implementation()
        parser.parse(string:"**a*b***") { (result:NSAttributedString) in
            XCTAssertEqual(result.string, "ab", "Failed to parse")
            let fontA:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            let fontB:UIFont? = result.attribute(NSAttributedString.Key.font, at:1, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA:UIFont = fontA {
                XCTAssertEqual(parsedFontA.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitBold)!.symbolicTraits, "Not bold")
            }
            if let parsedFontB:UIFont = fontB {
                XCTAssertEqual(parsedFontB.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    [UIFontDescriptor.SymbolicTraits.traitBold,
                     UIFontDescriptor.SymbolicTraits.traitItalic])!.symbolicTraits, "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
}
