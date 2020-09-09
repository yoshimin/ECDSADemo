//
//  KeyStore.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/02.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation
import CryptoKit

class KeyStore {
    private var keyPair: KeyPair?

    private func generateKeyPair() -> KeyPair {
        let privateKey = P256.Signing.PrivateKey()
        let publicKey = privateKey.publicKey
        let keyPair = KeyPair(privateKey: privateKey, publicKey: publicKey)
        self.keyPair = keyPair
        return keyPair
    }

    func getKeyPair() -> KeyPair {
        if let keyPair = self.keyPair { return keyPair }
        return generateKeyPair()
    }
}
