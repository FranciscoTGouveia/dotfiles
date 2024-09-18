{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    # This needs to actually be set to your username
    username = "francisco";
    homeDirectory = "/home/francisco";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "23.11";
  };



  programs.git = {
    enable = true;
    userName = "Francisco Tomé";
    userEmail = "francisco.t.gouveia@tecnico.ulisboa.ru";
  };
}
