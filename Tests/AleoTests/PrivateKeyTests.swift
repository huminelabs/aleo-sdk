//
//  PrivateKeyTests.swift
//  
//
//  Created by Nafeh Shoaib on 6/3/23.
//

import XCTest

@testable import RustXcframework
@testable import Aleo

final class PrivateKeyTests: XCTestCase {
    
    let privateKeyString = "APrivateKey1zkp3dQx4WASWYQVWKkq14v3RoQDfY2kbLssUj7iifi1VUQ6"
    let viewKeyString = "AViewKey1cxguxtKkjYnT9XDza9yTvVMxt6Ckb1Pv4ck1hppMzmCB"
    let addressString = "aleo184vuwr5u7u0ha5f5k44067dd2uaqewxx6pe5ltha5pv99wvhfqxqv339h4"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSanity() throws {
        let privateKey = PrivateKey(string: privateKeyString)
        
        let converted = privateKey.toString().toString()
        
        XCTAssertEqual(privateKeyString, converted)
    }
    
    func testToAddress() throws {
        let privateKey = PrivateKey()
        let expected = privateKey.toAddress()
        
        let viewKey = privateKey.toViewKey()
        let address = Address(viewKey: viewKey)
        
        XCTAssertEqual(expected, address)
    }

}
