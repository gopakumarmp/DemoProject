//
//  NSMutableRequestExtensions.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/7/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import Foundation

extension NSMutableURLRequest {
    func setAuthorizationHeader(username: String, password: String) -> Bool {
        guard let data = "\(username):\(password)".data(using: String.Encoding.utf8) else { return false }
        let base64 = data.base64EncodedString(options: [])
        setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        return true
    }
}
