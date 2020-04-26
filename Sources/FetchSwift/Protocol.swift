//
//  API.swift
//  TaxiGoRider-iOS
//
//  Created by Lova on 2019/11/6.
//  Copyright © 2019 taxigo. All rights reserved.
//

import Combine
import Foundation

public
enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public
protocol Fetch: AnyObject {
    typealias Params = [String: Any]

    var domain: String { get }
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }

    func willSend(params: [String: Any], method: Method, path: String, parameters: [String: Any]) -> Params
    func willSend(request: URLRequest, method: Method, path: String, parameters: [String: Any]) -> URLRequest

    func show(progress: Float?)
    func hide(progress: Float?)
}
