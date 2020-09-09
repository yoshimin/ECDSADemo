//
//  Data+ASN1.swift
//  ECDSADemo
//
//  Created by Shingai Yoshimi on 2020/09/09.
//  Copyright © 2020 Shingai Yoshimi. All rights reserved.
//

import Foundation

struct ASN1 {
    struct Value {
        let tag: UInt8
        let length: UInt8
        let data: Data
    }
    let sequence: UInt8
    let length: UInt8
    let values: [Value]
}

extension Data {
    func toASN1() throws -> ASN1 {
        var sequence: UInt8?
        var length: UInt8?
        var values: [ASN1.Value] = []

        var offset = 0
        while offset < count {
            let first = self[offset]
            offset += 1

            switch first {
            case 0x30:
                sequence = 0x30
                length = self[offset]
                offset += 1
            case 0x02:
                let length = self[offset]
                offset += 1

                var data = self[offset..<offset+Int(length)]
                offset += Int(length)

                let octetLength = 32
                guard data.count <= octetLength + 1 else {
                    throw SignatureError.invalidASN1
                }
                data = data.count == octetLength + 1 ? data.dropFirst() : data

                let value = ASN1.Value(tag: 0x02, length: length, data: data)
                values.append(value)
            default:
                throw SignatureError.invalidASN1
            }
        }
        guard let seq = sequence, let len = length, !values.isEmpty else {
            throw SignatureError.invalidASN1
        }
        return ASN1(sequence: seq, length: len, values: values)
    }
}
