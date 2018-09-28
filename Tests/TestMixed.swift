import XCTest
@testable import MarkdownHero

class TestMixed:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        parser = Parser()
    }
    
    func testParseItalicBoldStars() {
        let expect = expectation(description:String())
        parser.parse(string:"***hello world***") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitItalic, .traitBold])?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseItalicBoldUnderscores() {
        let expect = expectation(description:String())
        parser.parse(string:"___hello world___") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitItalic, .traitBold])?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseItalicBoldMixed() {
        let expect = expectation(description:String())
        parser.parse(string:"_**hello world**_") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitItalic, .traitBold])?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseBoldItalicMixed() {
        let expect = expectation(description:String())
        parser.parse(string:"**_hello world_**") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitItalic, .traitBold])?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseMixed() {
        let expect = expectation(description:String())
        parser.parse(string:"**a*b***") { result in
            XCTAssertEqual("ab", result.string, "Failed to parse")
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            let fontB = result.attribute(.font, at:1, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                .traitBold)?.symbolicTraits, fontA.fontDescriptor.symbolicTraits)
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitItalic, .traitBold])?.symbolicTraits, fontB.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
