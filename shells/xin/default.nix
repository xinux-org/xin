{
  cargo,
  clippy,
  darwin,
  lib,
  libiconv,
  mkShell,
  openssl,
  pkg-config,
  polkit,
  rust-analyzer,
  rust,
  rustc,
  rustfmt,
  sqlite,
  stdenv,
  nixd,
  nixfmt
}:

mkShell {
  nativeBuildInputs =
    [
      cargo
      clippy
      openssl
      pkg-config
      polkit
      rust-analyzer
      rustc
      rustfmt
      sqlite
      nixd
      nixfmt
    ]
    ++ lib.optionals stdenv.isDarwin ([
      darwin.apple_sdk.frameworks.Security
      libiconv
    ]);
  RUST_SRC_PATH = "${rust.packages.stable.rustPlatform.rustLibSrc}";
}
