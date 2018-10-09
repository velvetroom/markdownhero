import XCTest
@testable import MarkdownHero

class TestBold:XCTestCase {
    private var parser:Hero!
    
    override func setUp() {
        parser = Hero()
    }
    
    func testParseBoldStars() {
        let expect = expectation(description:String())
        parser.parse(string:"**hello world**") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                .traitBold)?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testParseBoldUnderscore() {
        let expect = expectation(description:String())
        parser.parse(string:"__hello world__") { result in
            XCTAssertEqual("hello world", result.string)
            let font = result.attribute(.font, at:0, effectiveRange:nil) as! UIFont
            XCTAssertEqual(UIFontDescriptor(name:self.parser.font.familyName, size:14).withSymbolicTraits(
                .traitBold)?.symbolicTraits, font.fontDescriptor.symbolicTraits)
            expect.fulfill()
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
