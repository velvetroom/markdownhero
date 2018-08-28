import XCTest
@testable import MarkdownHero

class TestHeader:XCTestCase {
    private var parser:Parser!
    
    override func setUp() {
        parser = Parser()
    }
    
    func testH1() {
        let expect = expectation(description:String())
        parser.parse(string:"# hello world") { (result) in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertGreaterThan(font.pointSize, self.parser.font.pointSize)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testH2() {
        let expect = expectation(description:String())
        parser.parse(string:"## hello world") { (result) in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertGreaterThan(font.pointSize, self.parser.font.pointSize)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testH3() {
        let expect = expectation(description:String())
        parser.parse(string:"### hello world") { (result) in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertGreaterThan(font.pointSize, self.parser.font.pointSize)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testHeaderAndPlain() {
        let expect = expectation(description:String())
        parser.parse(string:"# hello world\nlorem ipsum") { (result) in
            XCTAssertEqual("hello world\nlorem ipsum", result.string)
            let font = result.attribute(.font, at:13, effectiveRange:nil) as! UIFont
            XCTAssertEqual(self.parser.font.fontDescriptor.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
