pub use aleo_rust::{
    Address, Ciphertext, Encryptor, Identifier, Plaintext, PrivateKey, ProgramID, Record, Signature, Testnet3, ViewKey,
};
use snarkvm_circuit_network::AleoV0;
use snarkvm_console::program::{ProgramOwner, Response, TransactionLeaf};
use snarkvm_synthesizer::{
    helpers::memory::BlockMemory,
    snark::{ProvingKey, VerifyingKey},
    Process, Program, Transaction,
};

pub use snarkvm_wasm::{network::Environment, FromBytes, PrimeField, ToBytes};

// Account types
pub type AddressNative = Address<CurrentNetwork>;
pub type PrivateKeyNative = PrivateKey<CurrentNetwork>;
pub type SignatureNative = Signature<CurrentNetwork>;
pub type ViewKeyNative = ViewKey<CurrentNetwork>;

// Network types
pub type CurrentNetwork = Testnet3;
pub type CurrentAleo = AleoV0;

// Record types
pub type CiphertextNative = Ciphertext<CurrentNetwork>;
pub type PlaintextNative = Plaintext<CurrentNetwork>;
pub type RecordCiphertextNative = Record<CurrentNetwork, CiphertextNative>;
pub type RecordPlaintextNative = Record<CurrentNetwork, PlaintextNative>;

// Program types
pub type CurrentBlockMemory = BlockMemory<CurrentNetwork>;
pub type IdentifierNative = Identifier<CurrentNetwork>;
pub type ProcessNative = Process<CurrentNetwork>;
pub type ProgramNative = Program<CurrentNetwork>;
pub type ProgramIDNative = ProgramID<CurrentNetwork>;
pub type ProgramOwnerNative = ProgramOwner<CurrentNetwork>;
pub type ProvingKeyNative = ProvingKey<CurrentNetwork>;
pub type ResponseNative = Response<CurrentNetwork>;
pub type TransactionLeafNative = TransactionLeaf<CurrentNetwork>;
pub type TransactionNative = Transaction<CurrentNetwork>;
pub type VerifyingKeyNative = VerifyingKey<CurrentNetwork>;
