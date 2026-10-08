{ pkgs, ... }:

{
  packages = with pkgs; [
    gcc
    binutils
    gdb
    nasm
    lldb
    asm-lsp
  ];
}
