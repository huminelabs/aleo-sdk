//
//  PrivateKeyCiphertextTests.swift
//  
//
//  Created by Nafeh Shoaib on 6/3/23.
//

import XCTest

@testable import RustXcframework
@testable import Aleo

final class PrivateKeyCiphertextTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToAndFromString() throws {
        let privateKeyString = "APrivateKey1zkpAYS46Dq4rnt9wdohyWMwdmjmTeMJKPZdp5AhvjXZDsVG"
        let ciphertextString = "ciphertext1qvqg7rgvam3xdcu55pwu6sl8rxwefxaj5gwthk0yzln6jv5fastzup0qn0qftqlqq7jcckyx03fzv9kke0z9puwd7cl7jzyhxfy2f2juplz39dkqs6p24urhxymhv364qm3z8mvyklv5gr52n4fxr2z59jgqytyddj8"
        let secretString = "mypassword"
        
        let privateKey = PrivateKey(string: privateKeyString)
        let ciphertext = PrivateKeyCiphertext.from(ciphertext: ciphertextString)
        let decryptedPrivateKey = ciphertext.decryptToPrivateKey(secret: secretString)
        
        print("""
            Aleo Private Key Ciphertext Tests:
            
            private key: \(privateKey.toString().toString())
            ciphertext: \(ciphertext.toString().toString())
            decrypted private key: \(decryptedPrivateKey.toString().toString())
            """)
        
        XCTAssertEqual(privateKey, decryptedPrivateKey)
    }
    
    func testPrivateKeyCiphertextEncryptAndDecrypt() throws {
        let privateKey = PrivateKey()
        let privateKeyCiphertext = PrivateKeyCiphertext.encrypt(privateKey: privateKey, secret: "mypassword")
        let decrypted = privateKeyCiphertext.decryptToPrivateKey(secret: "mypassword")
        
        XCTAssertEqual(privateKey, decrypted)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
