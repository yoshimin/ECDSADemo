//
//  JWK.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/02.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation
import CryptoKit

/*
 JWK (JSON Web Key) is a JavaScript Object Notation (JSON) data structure that represents a cryptographic key.
 https://tools.ietf.org/html/rfc7518#section-7.5
 */
struct JWK: Encodable {
    let kty: String
    let crv: String
    let x: String
    let y: String
}

extension JWK {
    init(publicKey: P256.Signing.PublicKey) throws {
        var data = publicKey.x963Representation
        let count = data.count

        guard data.removeFirst() == 0x04 else {
            throw SignatureError.invalidPublicKey
        }

        let size = count / 2
        let xData = data[..<size]
        let yData = data[size...]

        kty = "EC"
        crv = "P-256"
        x = xData.base64urlEncodedString()
        y = yData.base64urlEncodedString()
    }
}
