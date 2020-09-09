//
//  KeyPair.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/02.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation
import CryptoKit

struct KeyPair {
    let privateKey: P256.Signing.PrivateKey
    let publicKey: P256.Signing.PublicKey
}
