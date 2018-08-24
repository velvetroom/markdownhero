import XCTest
@testable import MarkdownHero

class TestImplementation:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testReturnsOnMainThread() {
        let expect = expectation(description:"Not returning")
        DispatchQueue.global(qos:.background).async {
            self.parser.parse(string:String()) { (_) in
                XCTAssertEqual(Thread.current, Thread.main, "Not main thread")
                expect.fulfill()
            }
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParsePlainText() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let parser = Parser()
        parser.parse(string:text) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testPlainAfterItalics() {
        let expect = expectation(description:"Not returning")
        parser.parse(string:"_lorem_ ipsum") { (result) in
            XCTAssertEqual(result.string, "lorem ipsum", "Failed to parse")
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            let fontB = result.attribute(.font, at:6, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA = fontA {
                XCTAssertEqual(parsedFontA.fontDescriptor.symbolicTraits,
                               self.parser.font.fontDescriptor.withSymbolicTraits(.traitItalic)!.symbolicTraits,
                               "Not bold")
            }
            if let parsedFontB = fontB {
                XCTAssertEqual(parsedFontB.fontDescriptor.symbolicTraits,
                               self.parser.font.fontDescriptor.symbolicTraits, "Not plain text")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testPlainAfterBoldItalics() {
        let expect = expectation(description:"Not returning")
        parser.parse(string:"***lorem*** ipsum") { (result) in
            XCTAssertEqual(result.string, "lorem ipsum", "Failed to parse")
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            let fontB = result.attribute(.font, at:6, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA = fontA {
                XCTAssertEqual(parsedFontA, UIFont(descriptor:UIFont.systemFont(
                    ofSize:self.parser.font.pointSize, weight:.heavy).fontDescriptor.withSymbolicTraits(.traitItalic)!,
                                                   size:self.parser.font.pointSize), "Not italics bold")
            }
            if let parsedFontB = fontB {
                XCTAssertEqual(parsedFontB.fontDescriptor.symbolicTraits,
                               self.parser.font.fontDescriptor.symbolicTraits, "Not plain text")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testCleans() {
        let parsed = parser.parse(string:"\n- hello\n- world")
        XCTAssertEqual(parsed.string, "\n• hello\n• world")
    }
}
