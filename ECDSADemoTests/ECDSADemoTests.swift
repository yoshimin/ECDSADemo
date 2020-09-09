//
//  ECDSADemoTests.swift
//  ECDSADemoTests
//
//  Created by Shingai Yoshimi on 2020/09/09.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import XCTest
import CryptoKit

class ECDSADemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConvertDERToRaw() throws {
        let headerData = "{\"alg\":\"ES256\"}".data(using: .utf8)
        let claimsData = "{\"iss\":\"joe\",\"exp\":1300819380,\"http://example.com/is_root\":true}".data(using: .utf8)

        let privateKey = P256.Signing.PrivateKey()

        guard let header = headerData?.base64urlEncodedString(),
            let claims = claimsData?.base64urlEncodedString(),
            let data = "\(header).\(claims)".data(using: .utf8) else {
                assert(false)
        }

        let signature = try privateKey.signature(for: data)
        let asn1 = try signature.derRepresentation.toASN1()
        let raw = asn1.values[0].data + asn1.values[1].data

        print(signature.rawRepresentation.base64urlEncodedString())
        print(raw.base64urlEncodedString())
        XCTAssertEqual(signature.rawRepresentation.base64urlEncodedString(), raw.base64urlEncodedString())
    }

}
