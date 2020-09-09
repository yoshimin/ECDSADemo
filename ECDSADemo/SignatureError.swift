//
//  ECDSAError.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/03.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation

enum SignatureError: Error {
    case invalidPublicKey
    case invalidJWT
    case invalidASN1
}
