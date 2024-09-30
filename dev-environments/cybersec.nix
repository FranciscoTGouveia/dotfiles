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
    nmap
    wireshark
  ];
}
