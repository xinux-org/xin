{
  description = "An operating system manager for Xinux";

  inputs = {
    nixpkgs.url = "github:xinux-org/nixpkgs/nixos-25.05";
    xinux-lib = {
      url = "github:xinux-org/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    libxinux = {
      url = "github:xinux-org/libxinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.xinux-lib.mkFlake {
      inherit inputs;
      alias.packages.default = "xin";
      alias.shells.default = "xin";
      src = ./.;
    };
}
