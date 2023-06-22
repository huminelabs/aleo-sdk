use super::{Address, PrivateKey};
use crate::types::ViewKeyNative;

use core::{convert::TryFrom, fmt, ops::Deref, str::FromStr};

#[swift_bridge::bridge]
pub mod ffi_view_key {
    extern "Rust" {
        #[swift_bridge(Equatable)]
        type ViewKey;

        #[swift_bridge(already_declared)]
        type Address;
        #[swift_bridge(already_declared)]
        type PrivateKey;

        #[swift_bridge(init, associated_to = ViewKey)]
        pub fn from_private_key(private_key: &PrivateKey) -> ViewKey;

        #[swift_bridge(init, associated_to = ViewKey)]
        pub fn from_string(view_key: &str) -> ViewKey;

        #[swift_bridge(associated_to = ViewKey)]
        pub fn to_string(self: &ViewKey) -> String;
        #[swift_bridge(associated_to = ViewKey)]
        pub fn to_address(self: &ViewKey) -> Address;
        // #[swift_bridge(associated_to = ViewKey)]
        // pub fn decrypt(self: &ViewKey, ciphertext: &str) -> Result<String, String>;
    }
}

#[derive(Clone, PartialEq, Eq)]
pub struct ViewKey(ViewKeyNative);

impl ViewKey {
    pub fn from_private_key(private_key: &PrivateKey) -> Self {
        Self(ViewKeyNative::try_from(**private_key).unwrap())
    }

    pub fn from_string(view_key: &str) -> Self {
        Self::from_str(view_key).unwrap()
    }

    pub fn to_string(&self) -> String {
        self.0.to_string()
    }

    pub fn to_address(&self) -> Address {
        Address::from_view_key(self)
    }

    // pub fn decrypt(&self, ciphertext: &str) -> Result<String, String> {
    //     let ciphertext = RecordCiphertext::from_str(ciphertext).map_err(|error| error.to_string())?;
    //     match ciphertext.decrypt(self) {
    //         Ok(plaintext) => Ok(plaintext.to_string()),
    //         Err(error) => Err(error),
    //     }
    // }
}

impl FromStr for ViewKey {
    type Err = anyhow::Error;

    fn from_str(view_key: &str) -> Result<Self, Self::Err> {
        Ok(Self(ViewKeyNative::from_str(view_key)?))
    }
}

impl fmt::Display for ViewKey {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl Deref for ViewKey {
    type Target = ViewKeyNative;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
