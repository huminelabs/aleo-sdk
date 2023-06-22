use crate::{
    account::{Address, PrivateKeyCiphertext, Signature, ViewKey},
    types::{CurrentNetwork, Encryptor, Environment, FromBytes, PrimeField, PrivateKeyNative, ToBytes},
};

use core::{convert::TryInto, fmt, ops::Deref, str::FromStr};
use rand::{rngs::StdRng, SeedableRng};

#[swift_bridge::bridge]
mod ffi_private_key {
    extern "Rust" {
        #[swift_bridge(Equatable)]
        type PrivateKey;

        #[swift_bridge(already_declared)]
        type PrivateKeyCiphertext;
        #[swift_bridge(already_declared)]
        type ViewKey;
        #[swift_bridge(already_declared)]
        type Address;
        #[swift_bridge(already_declared)]
        type Signature;

        #[swift_bridge(init, associated_to = PrivateKey)]
        pub fn new() -> PrivateKey;

        #[swift_bridge(init, associated_to = PrivateKey)]
        pub fn from_seed_unchecked(#[swift_bridge(label = "seedUnchecked")] seed: &[u8]) -> PrivateKey;

        #[swift_bridge(init, associated_to = PrivateKey)]
        pub fn from_string(#[swift_bridge(label = "string")] private_key: &str) -> PrivateKey;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "toString")]
        pub fn to_string(self: &PrivateKey) -> String;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "toViewKey")]
        pub fn to_view_key(self: &PrivateKey) -> ViewKey;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "toAddress")]
        pub fn to_address(self: &PrivateKey) -> Address;

        #[swift_bridge(associated_to = PrivateKey)]
        pub fn sign(self: &PrivateKey, #[swift_bridge(label = "message")] message: &[u8]) -> Signature;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "newEncrypted")]
        pub fn new_encrypted(#[swift_bridge(label = "secret")] secret: &str) -> PrivateKeyCiphertext;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "toCiphertext")]
        pub fn to_ciphertext(self: &PrivateKey, #[swift_bridge(label = "secret")] secret: &str)
            -> PrivateKeyCiphertext;

        #[swift_bridge(associated_to = PrivateKey, swift_name = "from")]
        pub fn from_private_key_ciphertext(
            #[swift_bridge(label = "privateKeyCipherText")] ciphertext: &PrivateKeyCiphertext,
            #[swift_bridge(label = "secret")] secret: &str,
        ) -> PrivateKey;
    }
}

#[derive(Clone, Eq, PartialEq)]
pub struct PrivateKey(PrivateKeyNative);

impl PrivateKey {
    /// Generate a new private key
    pub fn new() -> Self {
        Self(PrivateKeyNative::new(&mut StdRng::from_entropy()).unwrap())
    }

    /// Get a private key from a series of unchecked bytes
    pub fn from_seed_unchecked(seed: &[u8]) -> PrivateKey {
        // Cast into a fixed-size byte array. Note: This is a **hard** requirement for security.
        let seed: [u8; 32] = seed.try_into().unwrap();
        // Recover the field element deterministically.
        let field = <CurrentNetwork as Environment>::Field::from_bytes_le_mod_order(&seed);
        // Cast and recover the private key from the seed.
        Self(PrivateKeyNative::try_from(FromBytes::read_le(&*field.to_bytes_le().unwrap()).unwrap()).unwrap())
    }

    /// Create a private key from a string representation
    ///
    /// This function will fail if the text is not a valid private key
    pub fn from_string(private_key: &str) -> PrivateKey {
        let private_key = Self::from_str(private_key).map_err(|_| "Invalid private key".to_string()).unwrap();

        return private_key;
    }

    /// Get a string representation of the private key
    ///
    /// This function should be used very carefully as it exposes the private key plaintext
    pub fn to_string(&self) -> String {
        self.0.to_string()
    }

    /// Get the view key corresponding to the private key
    pub fn to_view_key(&self) -> ViewKey {
        ViewKey::from_private_key(self)
    }

    /// Get the address corresponding to the private key
    pub fn to_address(&self) -> Address {
        Address::from_private_key(self)
    }

    /// Sign a message with the private key
    pub fn sign(&self, message: &[u8]) -> Signature {
        Signature::sign(self, message)
    }

    /// Get a private key ciphertext using a secret.
    ///
    /// The secret is sensitive and will be needed to decrypt the private key later, so it should be stored securely
    pub fn new_encrypted(secret: &str) -> PrivateKeyCiphertext {
        let key = Self::new();
        let ciphertext = Encryptor::encrypt_private_key_with_secret(&key, secret)
            .map_err(|_| "Encryption failed".to_string())
            .unwrap();
        return PrivateKeyCiphertext::from(ciphertext);
    }

    /// Encrypt the private key with a secret.
    ///
    /// The secret is sensitive and will be needed to decrypt the private key later, so it should be stored securely
    pub fn to_ciphertext(&self, secret: &str) -> PrivateKeyCiphertext {
        let ciphertext = Encryptor::encrypt_private_key_with_secret(self, secret)
            .map_err(|_| "Encryption failed".to_string())
            .unwrap();
        PrivateKeyCiphertext::from(ciphertext)
    }

    /// Get private key from a private key ciphertext using a secret.
    pub fn from_private_key_ciphertext(ciphertext: &PrivateKeyCiphertext, secret: &str) -> PrivateKey {
        let private_key = Encryptor::decrypt_private_key_with_secret(ciphertext, secret)
            .map_err(|_| "Decryption failed".to_string())
            .unwrap();
        Self::from(private_key)
    }
}

impl From<PrivateKeyNative> for PrivateKey {
    fn from(private_key: PrivateKeyNative) -> Self {
        Self(private_key)
    }
}

impl From<PrivateKey> for PrivateKeyNative {
    fn from(private_key: PrivateKey) -> Self {
        private_key.0
    }
}

impl From<&PrivateKey> for PrivateKeyNative {
    fn from(private_key: &PrivateKey) -> Self {
        private_key.0
    }
}
impl FromStr for PrivateKey {
    type Err = anyhow::Error;

    fn from_str(private_key: &str) -> Result<Self, Self::Err> {
        Ok(Self(PrivateKeyNative::from_str(private_key)?))
    }
}

impl fmt::Display for PrivateKey {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl Deref for PrivateKey {
    type Target = PrivateKeyNative;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}
