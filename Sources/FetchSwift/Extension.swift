//
//  Body.swift
//  LOAPI
//
//  Created by Lova on 2020/3/29.
//  Copyright © 2020 taxigo. All rights reserved.
//

import Combine
import Foundation

public
extension Fetch {
    typealias Response<T> = Publishers.ReceiveOn<AnyPublisher<T, Never>, DispatchQueue>

    private func call(method: Method = .get, path: String, parameters: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = true) -> Publishers.Map<URLSession.DataTaskPublisher, Data> {
        var params = parameters

        params = self.willSend(params: params, method: method, path: path, parameters: parameters)

        let url = URL(string: domain + path)!

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        switch method {
        case .get:
            request.url = url.addParameter(params)
        case .post, .put, .delete:
            request.addValue("Content-Type: application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyString = params.queryParameters
            request.httpBody = bodyString.data(using: .utf8)
        }

        request = self.willSend(request: request, method: method, path: path, parameters: parameters)

        if showHUD {
            self.show(progress: nil)
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { response -> Data in

                if showHUD {
                    self.hide(progress: nil)
                }

                let data = response.data
                return data
            }
    }

//    func call(method: Method = .get, path: String, parameters: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = true) -> Publishers.ReceiveOn<AnyPublisher<String?, Never>, DispatchQueue> {
//        self.call(method: method, path: path, parameters: parameters, showHUD: showHUD, showErrorMessage: showErrorMessage)
//            .map { String(data: $0, encoding: .utf8) }
//            .replaceError(with: nil)
//            .eraseToAnyPublisher()
//            .receive(on: DispatchQueue.main)
//    }

    func call(method: Method = .get, path: String, parameters: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = true) -> Response<Any?> {
        self.call(method: method, path: path, parameters: parameters, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .map { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
    }

    func call<T: Codable>(method: Method = .get, path: String, parameters: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = true) -> Response<[T]> {
        self.call(method: method, path: path, parameters: parameters, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .decode(type: [T].self, decoder: self.decoder)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
    }

    func call<T: Codable>(method: Method = .get, path: String, parameters: [String: Any] = [:], showHUD: Bool = false, showErrorMessage: Bool = true) -> Response<T?> {
        self.call(method: method, path: path, parameters: parameters, showHUD: showHUD, showErrorMessage: showErrorMessage)
            .decode(type: T?.self, decoder: self.decoder)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
    }
}
