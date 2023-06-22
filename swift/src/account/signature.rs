use crate::{
    account::{Address, PrivateKey},
    types::SignatureNative,
};

use core::{fmt, ops::Deref, str::FromStr};
use rand::{rngs::StdRng, SeedableRng};

#[swift_bridge::bridge]
pub mod ffi_signature {
    extern "Rust" {
        type Signature;

        #[swift_bridge(already_declared)]
        type Address;
        #[swift_bridge(already_declared)]
        type PrivateKey;

        #[swift_bridge(init, associated_to = Signature)]
        pub fn sign(
            #[swift_bridge(label = "privateKey")] private_key: &PrivateKey,
            #[swift_bridge(label = "message")] message: &[u8],
        ) -> Signature;

        #[swift_bridge(associated_to = Signature)]
        pub fn verify(
            self: &Signature,
            #[swift_bridge(label = "address")] address: &Address,
            #[swift_bridge(label = "message")] message: &[u8],
        ) -> bool;

        #[swift_bridge(init, associated_to = Signature, swift_name = "from")]
        pub fn from_string(#[swift_bridge(label = "string")] signature: &str) -> Signature;

        #[swift_bridge(associated_to = Signature, swift_name = "toString")]
        pub fn to_string(self: &Signature) -> String;
    }
}

pub struct Signature(SignatureNative);

impl Signature {
    pub fn sign(private_key: &PrivateKey, message: &[u8]) -> Self {
        Self(SignatureNative::sign_bytes(private_key, message, &mut StdRng::from_entropy()).unwrap())
    }

    pub fn verify(&self, address: &Address, message: &[u8]) -> bool {
        self.0.verify_bytes(address, message)
    }

    pub fn from_string(signature: &str) -> Self {
        Self::from_str(signature).unwrap()
    }

    pub fn to_string(&self) -> String {
        self.0.to_string()
    }
}

impl FromStr for Signature {
    type Err = anyhow::Error;

    fn from_str(signature: &str) -> Result<Self, Self::Err> {
        Ok(Self(SignatureNative::from_str(signature).unwrap()))
    }
}

impl fmt::Display for Signature {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl Deref for Signature {
    type Target = SignatureNative;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
