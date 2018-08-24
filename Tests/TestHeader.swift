import XCTest
@testable import MarkdownHero

class TestHeader:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testH1() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "# \(text)"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertGreaterThan(parsedFont.pointSize, self.parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testH2() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "## \(text)"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertGreaterThan(parsedFont.pointSize, self.parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testH3() {
        let expect = expectation(description:"Not returning")
        let text = "hello world"
        let decorated = "### \(text)"
        parser.parse(string:decorated) { (result) in
            XCTAssertEqual(result.string, text, "Failed to parse")
            let font = result.attribute(.font, at:0, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertGreaterThan(parsedFont.pointSize, self.parser.font.pointSize, "Font not bigger")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testHeaderAndPlain() {
        let expect = expectation(description:"Not returning")
        parser.parse(string:"# hello world\nlorem ipsum") { (result) in
            XCTAssertEqual(result.string, "hello world\nlorem ipsum", "Failed to parse")
            let font = result.attribute(NSAttributedString.Key.font, at:13, effectiveRange:nil) as? UIFont
            XCTAssertNotNil(font, "Has no font")
            if let parsedFont = font {
                XCTAssertEqual(parsedFont.fontDescriptor.symbolicTraits, self.parser.font.fontDescriptor.symbolicTraits,
                               "Not plain")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
