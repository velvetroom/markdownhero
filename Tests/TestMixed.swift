import XCTest
@testable import MarkdownHero

class TestMixed:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testParseItalicBoldStars() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "***\(text)***"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                  size:self.parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseItalicBoldUnderscores() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "___\(text)___"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                  size:self.parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseItalicBoldMixed() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "_**\(text)**_"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                  size:self.parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseBoldItalicMixed() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "**_\(text)_**"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont, UIFont(descriptor:UIFont.systemFont(ofSize:
                    self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                  size:self.parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseMixed() {
        let expect = expectation(description:"Not returning")
        parser.parse(string:"**a*b***") { (result) in
            XCTAssertEqual(result.string, "ab", "Failed to parse")
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            let fontB = result.attribute(.font, at:1, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA = fontA {
                XCTAssertEqual(UIFont.systemFont(ofSize:self.parser.font.pointSize, weight:.heavy), parsedFontA,
                               "Not bold")
            }
            if let parsedFontB = fontB {
                XCTAssertEqual(parsedFontB, UIFont(descriptor:UIFont.systemFont(ofSize:
                    self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                   size:self.parser.font.pointSize), "Not italics bold")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
