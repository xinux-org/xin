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
    inputs.libxinux.packages.${stdenv.hostPlatform.system}.libxinux-helper
    openssl
    sqlite
  ]);

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/xin --prefix PATH : '${"${inputs.libxinux.packages.${stdenv.hostPlatform.system}.libxinux-helper}/libexec:${inputs.libxinux.packages.${stdenv.hostPlatform.system}.libxinux-helper}/share/libxinux/triggers"}'
  '';
}
