import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FetchSwiftTests.allTests),
    ]
}
#endif
