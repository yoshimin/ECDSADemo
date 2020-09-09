//
//  Data+base64.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/03.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation

extension Data {
    func base64urlEncodedString() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
