import XCTest
@testable import MarkdownHero

class TestImplementation:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        parser = Parser()
    }
    
    func testReturnsOnMainThread() {
        let expect = expectation(description:String())
        DispatchQueue.global(qos:.background).async {
            self.parser.parse(string:String()) { _ in
                XCTAssertEqual(Thread.main, Thread.current)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParsePlainText() {
        let expect = expectation(description:String())
        parser.parse(string:"hello world") { result in
            XCTAssertEqual("hello world", result.string)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testPlainAfterItalics() {
        let expect = expectation(description:String())
        parser.parse(string:"_lorem_ ipsum") { result in
            XCTAssertEqual("lorem ipsum", result.string)
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            let fontB = result.attribute(.font, at:6, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                .traitItalic)?.symbolicTraits, fontA.fontDescriptor.symbolicTraits)
            XCTAssertEqual(self.parser.font.fontDescriptor.symbolicTraits, fontB.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testPlainAfterBoldItalics() {
        let expect = expectation(description:String())
        parser.parse(string:"***lorem*** ipsum") { result in
            XCTAssertEqual("lorem ipsum", result.string)
            let fontA = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            let fontB = result.attribute(.font, at:6, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                [.traitBold, .traitItalic])?.symbolicTraits, fontA.fontDescriptor.symbolicTraits)
            XCTAssertEqual(self.parser.font.fontDescriptor.symbolicTraits, fontB.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testCleans() {
        XCTAssertEqual("\n• hello\n• world", parser.parse(string:"\n- hello\n- world").string)
    }
}
