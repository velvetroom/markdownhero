import XCTest
@testable import MarkdownHero

class TestsScaping:XCTestCase {
    func testScaping() {
        let parsed:NSAttributedString = Implementation().parse(string:"``` # *hello *world***```")
        XCTAssertEqual(parsed.string, " # *hello *world***", "Not scaped")
    }
}
