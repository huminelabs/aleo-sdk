use std::path::PathBuf;

fn main() {
    let out_dir = PathBuf::from("./generated");
    let bridges = vec![
        "src/types.rs",
        "src/account/address.rs",
        "src/account/private_key_ciphertext.rs",
        "src/account/private_key.rs",
        "src/account/signature.rs",
        "src/account/view_key.rs",
    ];

    for path in &bridges {
        println!("cargo:rerun-if-changed={}", path);
    }

    swift_bridge_build::parse_bridges(bridges).write_all_concatenated(out_dir, env!("CARGO_PKG_NAME"));
}
