{
  darwin,
  inputs,
  lib,
  makeWrapper,
  openssl,
  pkg-config,
  rustPlatform,
  sqlite,
  stdenv,
  system,
}:
rustPlatform.buildRustPackage {
  pname = "xin";
  version = "0.1.0";

  src = [ ../.. ];

  cargoLock = {
    lockFile = ../../Cargo.lock;
  };

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];
  buildInputs = ([
    inputs.libxinux.packages.${system}.libxinux-helper
    openssl
    sqlite
  ]) ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ];

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/xin --prefix PATH : '${"${inputs.libxinux.packages.${system}.libxinux-helper}/libexec:${inputs.libxinux.packages.${system}.libxinux-helper}/share/libxinux/triggers"}'
  '';
}
