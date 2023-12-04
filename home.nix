{ config, pkgs, ... }:

{

  home.username = "john";
  home.homeDirectory = "/home/john";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    hello

  ];

  home.file = {
    ".gitconfig".text = ''
        [credential "https://github.com"]
            helper = !${config.home.homeDirectory}/.nix-profile/bin/gh auth git-credential
        [credential "https://gist.github.com"]
            helper = !${config.home.homeDirectory}/.nix-profile/bin/gh auth git-credential
        [user]
            email = noeljacob91@gmail.com
            name = Noel Jacob
    '';

    ".local/bin/hm" = {
        executable = true;
        source = "${config.home.homeDirectory}/home-manager/hm";
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
