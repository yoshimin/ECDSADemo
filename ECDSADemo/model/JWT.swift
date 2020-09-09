//
//  JWT.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/03.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation

struct JWTHeader: Encodable {
    let typ: String
    let alg: String
    let jwk: JWK
}

struct JWTClaims: Encodable {
    let jti: String
    let htm: String
    let htu: String
    let iat: UInt64
}
