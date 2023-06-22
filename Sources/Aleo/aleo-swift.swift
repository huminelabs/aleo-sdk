import RustXcframework







public class Address: AddressRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Address$_free(ptr)
        }
    }
}
extension Address {
    public convenience init(privateKey private_key: PrivateKeyRef) {
        self.init(ptr: __swift_bridge__$Address$from_private_key(private_key.ptr))
    }

    public convenience init(viewKey view_key: ViewKeyRef) {
        self.init(ptr: __swift_bridge__$Address$from_view_key(view_key.ptr))
    }

    public convenience init<GenericIntoRustString: IntoRustString>(_ address: GenericIntoRustString) {
        self.init(ptr: __swift_bridge__$Address$from_string({ let rustString = address.intoRustString(); rustString.isOwned = false; return rustString.ptr }()))
    }
}
public class AddressRefMut: AddressRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class AddressRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension AddressRef {
    public func to_string() -> RustString {
        RustString(ptr: __swift_bridge__$Address$to_string(ptr))
    }

    public func verify(_ message: UnsafeBufferPointer<UInt8>, _ signature: SignatureRef) -> Bool {
        __swift_bridge__$Address$verify(ptr, message.toFfiSlice(), signature.ptr)
    }
}
extension AddressRef: Equatable {
    public static func == (lhs: AddressRef, rhs: AddressRef) -> Bool {
        __swift_bridge__$Address$_partial_eq(rhs.ptr, lhs.ptr)
    }
}
extension Address: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Address$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Address$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Address) {
        __swift_bridge__$Vec_Address$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Address$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Address(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<AddressRef> {
        let pointer = __swift_bridge__$Vec_Address$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return AddressRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<AddressRefMut> {
        let pointer = __swift_bridge__$Vec_Address$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return AddressRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Address$len(vecPtr)
    }
}






public class PrivateKeyCiphertext: PrivateKeyCiphertextRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$PrivateKeyCiphertext$_free(ptr)
        }
    }
}
extension PrivateKeyCiphertext {
    class public func encrypt<GenericToRustStr: ToRustStr>(privateKey private_key: PrivateKeyRef, secret secret: GenericToRustStr) -> PrivateKeyCiphertext {
        return secret.toRustStr({ secretAsRustStr in
            PrivateKeyCiphertext(ptr: __swift_bridge__$PrivateKeyCiphertext$encrypt_private_key(private_key.ptr, secretAsRustStr))
        })
    }

    class public func from<GenericIntoRustString: IntoRustString>(ciphertext ciphertext: GenericIntoRustString) -> PrivateKeyCiphertext {
        PrivateKeyCiphertext(ptr: __swift_bridge__$PrivateKeyCiphertext$from_string({ let rustString = ciphertext.intoRustString(); rustString.isOwned = false; return rustString.ptr }()))
    }
}
public class PrivateKeyCiphertextRefMut: PrivateKeyCiphertextRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class PrivateKeyCiphertextRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension PrivateKeyCiphertextRef {
    public func decryptToPrivateKey<GenericToRustStr: ToRustStr>(secret secret: GenericToRustStr) -> PrivateKey {
        return secret.toRustStr({ secretAsRustStr in
            PrivateKey(ptr: __swift_bridge__$PrivateKeyCiphertext$decrypt_to_private_key(ptr, secretAsRustStr))
        })
    }

    public func toString() -> RustString {
        RustString(ptr: __swift_bridge__$PrivateKeyCiphertext$to_string(ptr))
    }
}
extension PrivateKeyCiphertextRef: Equatable {
    public static func == (lhs: PrivateKeyCiphertextRef, rhs: PrivateKeyCiphertextRef) -> Bool {
        __swift_bridge__$PrivateKeyCiphertext$_partial_eq(rhs.ptr, lhs.ptr)
    }
}
extension PrivateKeyCiphertext: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_PrivateKeyCiphertext$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_PrivateKeyCiphertext$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: PrivateKeyCiphertext) {
        __swift_bridge__$Vec_PrivateKeyCiphertext$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_PrivateKeyCiphertext$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (PrivateKeyCiphertext(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PrivateKeyCiphertextRef> {
        let pointer = __swift_bridge__$Vec_PrivateKeyCiphertext$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PrivateKeyCiphertextRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PrivateKeyCiphertextRefMut> {
        let pointer = __swift_bridge__$Vec_PrivateKeyCiphertext$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PrivateKeyCiphertextRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_PrivateKeyCiphertext$len(vecPtr)
    }
}












public class PrivateKey: PrivateKeyRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$PrivateKey$_free(ptr)
        }
    }
}
extension PrivateKey {
    public convenience init() {
        self.init(ptr: __swift_bridge__$PrivateKey$new())
    }

    public convenience init(seedUnchecked seed: UnsafeBufferPointer<UInt8>) {
        self.init(ptr: __swift_bridge__$PrivateKey$from_seed_unchecked(seed.toFfiSlice()))
    }

    public convenience init<GenericToRustStr: ToRustStr>(string private_key: GenericToRustStr) {
        self.init(ptr: private_key.toRustStr({ private_keyAsRustStr in
            __swift_bridge__$PrivateKey$from_string(private_keyAsRustStr)
        }))
    }
}
extension PrivateKey {
    class public func newEncrypted<GenericToRustStr: ToRustStr>(secret secret: GenericToRustStr) -> PrivateKeyCiphertext {
        return secret.toRustStr({ secretAsRustStr in
            PrivateKeyCiphertext(ptr: __swift_bridge__$PrivateKey$new_encrypted(secretAsRustStr))
        })
    }

    class public func from<GenericToRustStr: ToRustStr>(privateKeyCipherText ciphertext: PrivateKeyCiphertextRef, secret secret: GenericToRustStr) -> PrivateKey {
        return secret.toRustStr({ secretAsRustStr in
            PrivateKey(ptr: __swift_bridge__$PrivateKey$from_private_key_ciphertext(ciphertext.ptr, secretAsRustStr))
        })
    }
}
public class PrivateKeyRefMut: PrivateKeyRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class PrivateKeyRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension PrivateKeyRef {
    public func toString() -> RustString {
        RustString(ptr: __swift_bridge__$PrivateKey$to_string(ptr))
    }

    public func toViewKey() -> ViewKey {
        ViewKey(ptr: __swift_bridge__$PrivateKey$to_view_key(ptr))
    }

    public func toAddress() -> Address {
        Address(ptr: __swift_bridge__$PrivateKey$to_address(ptr))
    }

    public func sign(message message: UnsafeBufferPointer<UInt8>) -> Signature {
        Signature(ptr: __swift_bridge__$PrivateKey$sign(ptr, message.toFfiSlice()))
    }

    public func toCiphertext<GenericToRustStr: ToRustStr>(secret secret: GenericToRustStr) -> PrivateKeyCiphertext {
        return secret.toRustStr({ secretAsRustStr in
            PrivateKeyCiphertext(ptr: __swift_bridge__$PrivateKey$to_ciphertext(ptr, secretAsRustStr))
        })
    }
}
extension PrivateKeyRef: Equatable {
    public static func == (lhs: PrivateKeyRef, rhs: PrivateKeyRef) -> Bool {
        __swift_bridge__$PrivateKey$_partial_eq(rhs.ptr, lhs.ptr)
    }
}
extension PrivateKey: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_PrivateKey$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_PrivateKey$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: PrivateKey) {
        __swift_bridge__$Vec_PrivateKey$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_PrivateKey$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (PrivateKey(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PrivateKeyRef> {
        let pointer = __swift_bridge__$Vec_PrivateKey$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PrivateKeyRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<PrivateKeyRefMut> {
        let pointer = __swift_bridge__$Vec_PrivateKey$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return PrivateKeyRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_PrivateKey$len(vecPtr)
    }
}








public class Signature: SignatureRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$Signature$_free(ptr)
        }
    }
}
extension Signature {
    public convenience init(privateKey private_key: PrivateKeyRef, message message: UnsafeBufferPointer<UInt8>) {
        self.init(ptr: __swift_bridge__$Signature$sign(private_key.ptr, message.toFfiSlice()))
    }

    public convenience init<GenericToRustStr: ToRustStr>(string signature: GenericToRustStr) {
        self.init(ptr: signature.toRustStr({ signatureAsRustStr in
            __swift_bridge__$Signature$from_string(signatureAsRustStr)
        }))
    }
}
public class SignatureRefMut: SignatureRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class SignatureRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension SignatureRef {
    public func verify(address address: AddressRef, message message: UnsafeBufferPointer<UInt8>) -> Bool {
        __swift_bridge__$Signature$verify(ptr, address.ptr, message.toFfiSlice())
    }

    public func toString() -> RustString {
        RustString(ptr: __swift_bridge__$Signature$to_string(ptr))
    }
}
extension Signature: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_Signature$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_Signature$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Signature) {
        __swift_bridge__$Vec_Signature$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_Signature$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (Signature(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SignatureRef> {
        let pointer = __swift_bridge__$Vec_Signature$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SignatureRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SignatureRefMut> {
        let pointer = __swift_bridge__$Vec_Signature$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SignatureRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_Signature$len(vecPtr)
    }
}








public class ViewKey: ViewKeyRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$ViewKey$_free(ptr)
        }
    }
}
extension ViewKey {
    public convenience init(_ private_key: PrivateKeyRef) {
        self.init(ptr: __swift_bridge__$ViewKey$from_private_key(private_key.ptr))
    }

    public convenience init<GenericToRustStr: ToRustStr>(_ view_key: GenericToRustStr) {
        self.init(ptr: view_key.toRustStr({ view_keyAsRustStr in
            __swift_bridge__$ViewKey$from_string(view_keyAsRustStr)
        }))
    }
}
public class ViewKeyRefMut: ViewKeyRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class ViewKeyRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension ViewKeyRef {
    public func to_string() -> RustString {
        RustString(ptr: __swift_bridge__$ViewKey$to_string(ptr))
    }

    public func to_address() -> Address {
        Address(ptr: __swift_bridge__$ViewKey$to_address(ptr))
    }
}
extension ViewKeyRef: Equatable {
    public static func == (lhs: ViewKeyRef, rhs: ViewKeyRef) -> Bool {
        __swift_bridge__$ViewKey$_partial_eq(rhs.ptr, lhs.ptr)
    }
}
extension ViewKey: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_ViewKey$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_ViewKey$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: ViewKey) {
        __swift_bridge__$Vec_ViewKey$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_ViewKey$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (ViewKey(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ViewKeyRef> {
        let pointer = __swift_bridge__$Vec_ViewKey$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ViewKeyRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ViewKeyRefMut> {
        let pointer = __swift_bridge__$Vec_ViewKey$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ViewKeyRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_ViewKey$len(vecPtr)
    }
}



