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

    func testParams() {
        let dict = ["position": "kaohsung", "phone": "123123", "seat": "25"]

        var url = URL(string: "http://www.google.com.tw")!

        url = url.addParameter(dict)
        print(url)

        print(dict.queryParameters)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
