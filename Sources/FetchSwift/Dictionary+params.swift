//
//  Dictionary.swift
//  TaxiGoRider-iOS
//
//  Created by Lova on 2019/12/25.
//  Copyright © 2019 taxigo. All rights reserved.
//

import Foundation

extension Dictionary {
    var queryParameters: String {
        self.map { key, value -> String in
            String(format: "%@=%@", String(describing: key).urlEncoded, String(describing: value).urlEncoded)
        }.joined(separator: "&")
    }
}
