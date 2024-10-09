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

    # Networking
    nmap
    wireshark
    whois
    bind

    # Crypto
    python312Packages.pycrypto
    sage
  ];
}
