{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv
    git
    htop
    fastfetch
    bat
    mkalias
    tree
    tmux
    zoxide
    btop

    fd
    ripgrep
    fzf
    lazygit
    neovim

    # Duplicati breaks on Apple Silicon, so it is disabled for now.
    # duplicati
    obsidian
    brave
  ];
}