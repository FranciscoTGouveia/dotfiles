{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Forensics
    binwalk
    foremost
    john
    zsteg
    exiftool
    volatility3
    sleuthkit
    testdisk
    sqlite
    nmap
    wireshark

    # Crypto
    python312Packages.pycrypto
    sage
    openssl
  ];
}
