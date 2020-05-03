import Combine
@testable import FetchSwift
import XCTest

final class FetchSwiftTests: XCTestCase {
    var task: AnyCancellable?

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(FetchSwift().text, "Hello, World!")

        let expectation = XCTestExpectation(description: name)

        self.task = ExampleAPI.shared.test().sink { results in

            XCTAssertEqual(results.first?.id, 1)
            XCTAssertEqual(results.first?.userId, 1)
            XCTAssertEqual(results.first?.title, "delectus aut autem")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
