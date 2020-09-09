//
//  ContentViewModel.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/03.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation
import SwiftUI

protocol ContentViewModel {
    var inputs: ContentViewModelInputs { get }
    var outputs: ContentViewModelOutputs { get }
}

protocol ContentViewModelInputs {
    func generateSignature() throws
}

protocol ContentViewModelOutputs  {
    var signature: String { get }
}

class ContentViewModelImpl: ObservableObject {
    @Published private(set) var signature: String = ""

    private let keyStore = KeyStore()
}

extension ContentViewModelImpl: ContentViewModel {
    var inputs: ContentViewModelInputs { self }
    var outputs: ContentViewModelOutputs { self }
}

extension ContentViewModelImpl: ContentViewModelInputs {
    func generateSignature() throws {
        let keyPair = keyStore.getKeyPair()
        let header = try JWTHeader(
            typ: "dpop+jwt",
            alg: "ES256",
            jwk: JWK(publicKey: keyPair.publicKey)
        )
        let claims = JWTClaims(
            jti: UUID().uuidString,
            htm:"POST",
            htu:"https://server.example.com/token",
            iat: UInt64(Date().timeIntervalSince1970)
        )
        let signer = Signer(privateKey: keyPair.privateKey)
        signature = try signer.sign(header: header, claims: claims)
    }
}

extension ContentViewModelImpl: ContentViewModelOutputs {}
