{ config, pkgs, inputs, ... }: {

imports = [
  inputs.nixvim.homeModules.nixvim
  ./git
  ./kitty
  ./shell
  ./tmux
  ./scripts
  ./nvim
  ];

home = {
  # Home Manager needs a bit of information about you and the paths it should manage.
  username = "andrew";
  homeDirectory = "/home/andrew";

  # This value determines the Home Manager release that your configuration is compatible with. 
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager release notes.
  stateVersion = "23.11"; # Please read the comment ^ before changing.

  packages = with pkgs; 
  let

      # # 1. Import the special nixpkgs that has Rust 1.90
      # pkgs-rust190 = import inputs.nixpkgs-rust190 {
      #   system = pkgs.system;
      #   # Ensure its configuration matches your primary nixpkgs
      #   config = {}; #config.nixpkgs.config;
      # };

      # 2. Build the atuin-desktop package using our new derivation file.
      #    `callPackage` injects dependencies from `pkgs`, but we explicitly
      #    override `rustPlatform` to use the one from `pkgs-rust190`.
      atuin-desktop-latest = callPackage ./shell/atuin_desktop.nix {};
      #{
      #   rustPlatform = pkgs-rust190.rustPlatform;
      # };


      pyaudio = python312Packages.pyaudio;
      pythonWithPackages = python312.withPackages ( # From: https://github.com/stasjok/dotfiles/blob/cd39e95c29037d682cc9da4e25f86f8016d61682/home.nix#L18
        p: with p; [
          pydantic
          pynvim
          pip
          pyaudio
          selenium
          playwright
        ]
      );

  in  
  [
    #zsh
    atuin-desktop-latest
    fd
    bc
    gcc
    blueman
    unzip
    xdg-utils
    tldr
    wget
    curl
    ripgrep
    tree # temp
    sqlite
    postgresql
    docker
    tailscale

    # ollama
    htop
    git-filter-repo
    jq
    fw-ectool
    lm_sensors
    parted
    gparted
    qemu-user

    # Backup
    vscode
    firefox
    google-chrome 
    chromedriver
    chromium
    playwright
    playwright-driver #.browsers
    rustdesk-flutter
    gimp
    libation
    popsicle
    rpi-imager

    # Dev
    gitbutler
    cargo
    pythonWithPackages
    devenv
    fossil
    visidata
    go
    uv
    # fennel
    # fnlfmt
    # fennel-ls
    nim
    nimble
    tree-sitter
    nodejs
    code-cursor
    act
    delta
    diffsitter
    tig
    xdotool
    wmctrl

    # IDE
    inputs.IDE.packages.${pkgs.system}.default 
    statix
    ruff
    gh
    graphviz

    # # Misc
    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono

    # Notes
    obsidian
    hugo

    # Media
    vlc
    portaudio
    obs-studio
    file

    # Office
    libreoffice

    # Design
    spacenavd
    libspnav
    #bambu-studio
    blender

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is through 'home.file'.
  file = {
    # TODO: Investigate this further for managing scripts?
  };

  sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
  };
  
};
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Direnv for python management
  programs.direnv.enable = true;
}


