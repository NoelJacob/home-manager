{ config, pkgs, ... }:

let
  this = /. + config.home.homeDirectory + /home-manager;
in {

  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    hello
	jetbrains.idea-ultimate
	rustup
  ];

  home.file = {
    ".gitconfig".source = this + /gitconfig;

    ".local/bin/hm" = {
        executable = true;
        source = this + /hm;
    };
  };


  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/john/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "micro";
  };

  programs.home-manager = {
    enable = true;
#     path = "$HOME/home-manager";
  };

  programs.gh = {
    enable = true;
#     gitCredentialHelper = {
#       enable = true;
#       hosts = [
#         "https://github.com"
#         "https://gist.github.com"
#       ];
#     };
  };

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes repl-flake";
      auto-optimise-store = "true";
      bash-prompt-prefix = "(nix:$name)\\040";
      max-jobs = "auto";
      extra-nix-path = "nixpkgs=flake:nixpkgs";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

}
