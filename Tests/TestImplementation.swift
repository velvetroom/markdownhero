import XCTest
@testable import MarkdownHero

class TestImplementation:XCTestCase {
    func testReturnsOnMainThread() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Parser = Parser()
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            parser.parse(string:String()) { (_:NSAttributedString) in
                XCTAssertEqual(Thread.current, Thread.main, "Not main thread")
                expect.fulfill()
            }
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testParsePlainText() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let text:String = "hello world"
        let parser:Parser = Parser()
        parser.parse(string:text) { (result:NSAttributedString) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testPlainAfterItalics() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Parser = Parser()
        parser.parse(string:"_lorem_ ipsum") { (result:NSAttributedString) in
            XCTAssertEqual(result.string, "lorem ipsum", "Failed to parse")
            let fontA:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            let fontB:UIFont? = result.attribute(NSAttributedString.Key.font, at:6, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA:UIFont = fontA {
                XCTAssertEqual(parsedFontA.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.withSymbolicTraits(
                    UIFontDescriptor.SymbolicTraits.traitItalic)!.symbolicTraits, "Not bold")
            }
            if let parsedFontB:UIFont = fontB {
                XCTAssertEqual(parsedFontB.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.symbolicTraits,
                               "Not plain text")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testPlainAfterBoldItalics() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Parser = Parser()
        parser.parse(string:"***lorem*** ipsum") { (result:NSAttributedString) in
            XCTAssertEqual(result.string, "lorem ipsum", "Failed to parse")
            let fontA:UIFont? = result.attribute(NSAttributedString.Key.font, at:0, effectiveRange:nil) as? UIFont
            let fontB:UIFont? = result.attribute(NSAttributedString.Key.font, at:6, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(fontA, "Has no font A")
            XCTAssertNotNil(fontB, "Has no font B")
            if let parsedFontA:UIFont = fontA {
                XCTAssertEqual(parsedFontA, UIFont(descriptor:UIFont.systemFont(ofSize:
                    parser.font.pointSize, weight:UIFont.Weight.heavy).fontDescriptor.withSymbolicTraits(
                        UIFontDescriptor.SymbolicTraits.traitItalic)!, size:parser.font.pointSize), "Not italics bold")
            }
            if let parsedFontB:UIFont = fontB {
                XCTAssertEqual(parsedFontB.fontDescriptor.symbolicTraits, parser.font.fontDescriptor.symbolicTraits,
                               "Not plain text")
            }
            expect.fulfill()
        }
        self.waitForExpectations(timeout:1.0, handler:nil)
    }
    
    func testCleans() {
        let parsed:NSAttributedString = Parser().parse(string:"\n- hello\n- world")
        XCTAssertEqual(parsed.string, "\n• hello\n• world")
    }
}
