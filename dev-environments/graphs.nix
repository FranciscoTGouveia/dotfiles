{ pkgs ? import <nixpkgs> {} }:

let
  python = pkgs.python312;
  pythonPackages = python.pkgs;
in
pkgs.mkShell {
  buildInputs = with pythonPackages; [
    numpy
    networkx
    matplotlib
    pandas
    plotly
    scipy
  ];
}
