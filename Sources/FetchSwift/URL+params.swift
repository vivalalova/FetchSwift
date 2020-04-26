//
//  URL.swift
//  TaxiGoRider-iOS
//
//  Created by Lova on 2019/12/25.
//  Copyright © 2019 taxigo. All rights reserved.
//

import Combine
import Foundation

extension URL {
    func addParameter(_ dict: [String: Any]) -> URL {
        let string = "\(self.absoluteString)?\(dict.queryParameters)"

        guard let url = URL(string: string) else {
            fatalError("url")
        }

        return url
    }
}
