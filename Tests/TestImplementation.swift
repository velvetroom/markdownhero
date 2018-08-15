import XCTest
@testable import MarkdownHero

class TestImplementation:XCTestCase {
    func testReturnsOnMainThread() {
        let expect:XCTestExpectation = self.expectation(description:"Not returning")
        let parser:Implementation = Implementation()
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            parser.parse(string:String()) { (_:NSAttributedString) in
                XCTAssertEqual(Thread.current, Thread.main, "Not main thread")
                expect.fulfill()
            }
        }
        self.waitForExpectations(timeout:0.3, handler:nil)
    }
}
