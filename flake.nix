{
  description = "An operating system manager for Xinux";

  inputs = {
    nixpkgs.url = "github:xinux-org/nixpkgs/nixos-25.11";
    xinux-lib = {
      url = "github:xinux-org/lib/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    libxinux = {
      url = "github:xinux-org/libxinux/release-25.11";
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
      hydraJobs = inputs.self.packages.x86_64-linux;
    };
}
