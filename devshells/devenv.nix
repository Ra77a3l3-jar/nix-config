{
  profiles = {
    haskell.module = import ./haskell/devenv.nix;
    ros.module = import ./ros/devenv.nix;
    go.module = import ./go/devenv.nix;
    java.module = import ./java/devenv.nix;
    zig.module = import ./zig/devenv.nix;
    asm.module = import ./asm/devenv.nix;
    nix.module = import ./nix/devenv.nix;
    bash.module = import ./bash/devenv.nix;
  };
}
