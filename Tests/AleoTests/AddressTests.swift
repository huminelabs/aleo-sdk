//
//  AddressTests.swift
//
//
//  Created by Nafeh Shoaib on 6/2/23.
//

import XCTest

@testable import RustXcframework
@testable import Aleo

final class AddressTests: XCTestCase {
    func testSanity() throws {
        let privateKey = PrivateKey()
        let expected = Address(privateKey: privateKey)
        
        let viewKey = privateKey.toViewKey()
        let newAddress = Address(viewKey: viewKey)
        
        print("""
            Aleo address tests:
                private key: \(privateKey.toString().toString())
                viewKey: \(viewKey.to_string().toString())
                expected address: \(expected.to_string().toString())
                address: \(newAddress.to_string().toString())
            """)
        
        XCTAssertEqual(newAddress, expected)
    }
}

