import XCTest
@testable import MarkdownHero

class TestMixed:XCTestCase {
    func testParseItalicBoldStars() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "***\(text)***"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseItalicBoldUnderscores() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "___\(text)___"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseItalicBoldMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "_**\(text)**_"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseBoldItalicMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let decorated:String = "**_\(text)_**"
        let parser:Parser = Parser()
        parser.parse(string:decorated) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont:UIFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParseMixed() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Parser = Parser()
        parser.parse(string:"**a*b***") { (result:NSAttributedString) in
            XCTAssertEqual(result.string, "ab", "Failed to parse")
            let fontA:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            let fontB:UIFont? = result.attribute(NSAttributedString.Key.font, at:1, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA:UIFont = fontA {
                XCTAssertEqual(UIFont.systemFont(ofSize:parser.font.pointSize, weight:UIFont.Weight.heavy), parsedFontA,
                               "Not bold")
            }
            if let parsedFontB:UIFont = fontB {
                XCTAssertEqual(parsedFontB, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
}
