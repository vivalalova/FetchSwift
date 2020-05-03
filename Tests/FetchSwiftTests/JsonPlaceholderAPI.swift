//
//  File.swift
//
//
//  Created by Lova on 2020/5/3.
//

import Combine
@testable import FetchSwift
import Foundation

struct Todo: Codable {
    var id: Int?
    var userId: Int?
    var title: String?
    var completed: Bool?
}

final class ExampleAPI: Fetch {
    /// ref: https://jsonplaceholder.typicode.com/
    var domain: String = "https://jsonplaceholder.typicode.com/"

    var decoder = JSONDecoder()

    var encoder = JSONEncoder()

    static var shared: ExampleAPI = ExampleAPI()

    func willSend(params: [String: Any], method: FetchSwift.Method, path: String) -> Params {
        params
    }

    func willSend(request: URLRequest, method: FetchSwift.Method, path: String, params: [String: Any]) -> URLRequest {
        request
    }

    func show(progress: Float?) {}

    func hide(progress: Float?) {}

    func test() -> Response<[Todo]> {
        self.fetch(path: "todos")
    }
}
