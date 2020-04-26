//
//  String+URLEncoded.swift
//  TaxiGoRider-iOS
//
//  Created by Lova on 2020/3/1.
//  Copyright © 2020 taxigo. All rights reserved.
//

import Foundation

extension String {
    var urlEncoded: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }

    var urlDecoded: String {
        self.removingPercentEncoding ?? ""
    }
}
