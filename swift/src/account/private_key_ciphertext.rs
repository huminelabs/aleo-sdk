use crate::{
    account::PrivateKey,
    types::{CiphertextNative, Encryptor},
};

use std::{convert::TryFrom, ops::Deref, str::FromStr};

#[swift_bridge::bridge]
pub mod ffi_private_key_ciphertext {
    extern "Rust" {
        #[swift_bridge(Equatable)]
        type PrivateKeyCiphertext;

        #[swift_bridge(already_declared)]
        type PrivateKey;

        #[swift_bridge(associated_to = PrivateKeyCiphertext, swift_name = "encrypt")]
        pub fn encrypt_private_key(
            #[swift_bridge(label = "privateKey")] private_key: &PrivateKey,
            #[swift_bridge(label = "secret")] secret: &str,
        ) -> PrivateKeyCiphertext;
        #[swift_bridge(associated_to = PrivateKeyCiphertext, swift_name = "decryptToPrivateKey")]
        pub fn decrypt_to_private_key(
            self: &PrivateKeyCiphertext,
            #[swift_bridge(label = "secret")] secret: &str,
        ) -> PrivateKey;
        #[swift_bridge(associated_to = PrivateKeyCiphertext, swift_name = "toString")]
        pub fn to_string(self: &PrivateKeyCiphertext) -> String;
        #[swift_bridge(associated_to = PrivateKeyCiphertext, swift_name = "from")]
        pub fn from_string(#[swift_bridge(label = "ciphertext")] ciphertext: String) -> PrivateKeyCiphertext;
    }
}

#[derive(Clone, Eq, PartialEq)]
pub struct PrivateKeyCiphertext(CiphertextNative);

impl PrivateKeyCiphertext {
    pub fn encrypt_private_key(private_key: &PrivateKey, secret: &str) -> PrivateKeyCiphertext {
        let ciphertext = Encryptor::encrypt_private_key_with_secret(private_key, secret)
            .map_err(|_| "Encryption failed".to_string())
            .unwrap();
        Self::from(ciphertext)
    }

    pub fn decrypt_to_private_key(&self, secret: &str) -> PrivateKey {
        let private_key = Encryptor::decrypt_private_key_with_secret(&self.0, secret)
            .map_err(|_| "Decryption failed - ciphertext was not a private key")
            .unwrap();
        PrivateKey::from(private_key)
    }

    pub fn to_string(&self) -> String {
        self.0.to_string()
    }

    pub fn from_string(ciphertext: String) -> PrivateKeyCiphertext {
        let ciphertext = Self::try_from(ciphertext).map_err(|_| "Invalid ciphertext".to_string()).unwrap();
        return ciphertext;
    }
}

impl From<CiphertextNative> for PrivateKeyCiphertext {
    fn from(ciphertext: CiphertextNative) -> Self {
        Self(ciphertext)
    }
}

impl TryFrom<String> for PrivateKeyCiphertext {
    type Error = String;

    fn try_from(ciphertext: String) -> Result<Self, Self::Error> {
        Ok(Self(CiphertextNative::from_str(&ciphertext).map_err(|_| "Invalid ciphertext".to_string())?))
    }
}

impl Deref for PrivateKeyCiphertext {
    type Target = CiphertextNative;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
