use crate::{
    account::{PrivateKey, Signature, ViewKey},
    types::AddressNative,
};

use core::{convert::TryFrom, fmt, ops::Deref, str::FromStr};

#[swift_bridge::bridge]
pub mod ffi_address {
    extern "Rust" {
        #[swift_bridge(Equatable)]
        type Address;

        #[swift_bridge(already_declared)]
        type PrivateKey;
        #[swift_bridge(already_declared)]
        type ViewKey;
        #[swift_bridge(already_declared)]
        type Signature;

        #[swift_bridge(init, associated_to = Address)]
        pub fn from_private_key(#[swift_bridge(label = "privateKey")] private_key: &PrivateKey) -> Address;
        #[swift_bridge(init, associated_to = Address)]
        pub fn from_view_key(#[swift_bridge(label = "viewKey")] view_key: &ViewKey) -> Address;
        #[swift_bridge(init, associated_to = Address)]
        pub fn from_string(address: String) -> Address;

        #[swift_bridge(associated_to = Address)]
        pub fn to_string(self: &Address) -> String;
        #[swift_bridge(associated_to = Address)]
        pub fn verify(self: &Address, message: &[u8], signature: &Signature) -> bool;
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq)]
pub struct Address(AddressNative);

impl Address {
    pub fn from_private_key(private_key: &PrivateKey) -> Self {
        Self(AddressNative::try_from(**private_key).unwrap())
    }

    pub fn from_view_key(view_key: &ViewKey) -> Self {
        Self(AddressNative::try_from(**view_key).unwrap())
    }

    pub fn from_string(address: String) -> Self {
        Self::from_str(address.as_str()).unwrap()
    }

    pub fn to_string(&self) -> String {
        self.0.to_string()
    }

    pub fn verify(&self, message: &[u8], signature: &Signature) -> bool {
        signature.verify(self, message)
    }
}

impl FromStr for Address {
    type Err = anyhow::Error;

    fn from_str(address: &str) -> Result<Self, Self::Err> {
        Ok(Self(AddressNative::from_str(address)?))
    }
}

impl fmt::Display for Address {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl Deref for Address {
    type Target = AddressNative;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
