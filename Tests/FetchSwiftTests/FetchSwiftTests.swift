import Combine
@testable import FetchSwift
import XCTest

final class FetchSwiftTests: XCTestCase {
    var task: AnyCancellable?

    func testExample() {
        let expectation = XCTestExpectation(description: name)

        self.task = JsonPlaceholderAPI.shared.todos().sink { results in

            XCTAssertEqual(results.first?.id, 1)
            XCTAssertEqual(results.first?.userId, 1)
            XCTAssertEqual(results.first?.title, "delectus aut autem")
            XCTAssertEqual(results.first?.completed, false)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
