//
//  Signer.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/09.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation
import CryptoKit

struct Signer {
    private let privateKey: P256.Signing.PrivateKey

    init(privateKey: P256.Signing.PrivateKey) {
        self.privateKey = privateKey
    }

    func sign(header: JWTHeader, claims: JWTClaims) throws -> String {
        let encoder = JSONEncoder()
        guard let headerJson = try? encoder.encode(header).base64urlEncodedString(),
            let claimsJson = try? encoder.encode(claims).base64urlEncodedString() else {
                throw SignatureError.invalidJWT
        }

        let input = "\(headerJson).\(claimsJson)"
        guard let data = input.data(using: .utf8) else {
            throw SignatureError.invalidJWT
        }
        let signature = try privateKey.signature(for: data)
        return "\(input).\(signature.rawRepresentation.base64urlEncodedString())"
    }
}
