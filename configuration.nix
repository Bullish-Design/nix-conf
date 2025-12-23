# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #inputs.home-manager.nixosModules.default
      #./networking/wireguard.nix
    ];

  # Shell Aliases:
  environment.shellAliases = {
    nimr = "nim compile --run";
    copier-new = "uvx copier copy --trust gh:Bullish-Design/templateer";
    copier-update = "uvx copier update --trust --skip-tasks";
    uv-venv = "UV_NO_MANAGED_PYTHON=1 uv venv --no-python-downloads --python \"$(which python3)\"; echo; source .venv/bin/activate; echo";
    devboot = "devenv up -d; echo ; devenv shell zsh";
  };
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

  networking.hostName = "framework"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Framework Specific Configuration:
  services.fwupd.enable = true;
  services.tailscale.enable = true;
  
  # Enable Flakes:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [
    "andrew"
  ];

  # Insecure nixpkgs:
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
    "libsoup-2.74.3"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Disable IPv6
  networking.enableIPv6 = true; ## This is a workaround for some issues with IPv6 on NixOS.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  ## Hopefully stop the damn blueman notifications: <<< Nope - "error: The option `dconf' does not exist."
  #services.blueman-applet.enable = true;

  #dconf.settings."org/blueman/general" = {
  #  plugin-list = [ "!ConnectionNotifier" ];
  #};

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  # Syncthing: 
  services.syncthing = {
    enable           = true;
    guiAddress       = "127.0.0.1:8384";     # tunnel with ssh -L if remote
    openDefaultPorts = true;
    user             = "andrew";            # user running the service
    group            = "users";             # group owning the data
    dataDir          = "/home/andrew";       # Syncthing DB lives here
    configDir        = "/home/andrew/.config/syncthing";

    # # always trust the declarative list
    # overrideDevices  = true;
    # overrideFolders  = true;

    settings = {
      # ---- devices ----
      devices = {
        pi = {
          id         = "D2C6YFJ-2BC4Z7W-4QWJBSR-HBBGSRX-7JRXDZS-AI2W732-3LFQRBL-MJ55VQX";  # ← replace
          introducer = true;
        };
        laptop = {
          id = "RBTYZI7-GWMLVEN-75ZPH7S-EV5CWYY-OGYCPPE-EPJBCJC-C7EDBZE-HZFYNA2"; # fill in after first run
        };
      };

      # ---- folders ----
      folders."notes" = {
        path         = "/home/andrew/Documents/Notes";
        devices      = [ "pi" "laptop" ];
        ignorePerms  = true;
        # versioning.type = "";                # Git handles history
      };
    };
  };


  console = {
    useXkbConfig = true;
  };

  programs.zsh.enable = true; 

  users.defaultUserShell = pkgs.zsh;

  # Android Debug Bridge
  programs.adb.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew";
    extraGroups = [ "adbusers" "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
    ];
    shell = pkgs.zsh;
  };
  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh-zhooks
    #dive # look into docker image layers
    #podman-tui # status of containers in the terminal
    #docker-compose # start group of containers for dev
  ];

  environment.variables = {
    EDITOR = "nvim";
    TERM = "kitty";
    TMUXP_CONFIGDIR = "$HOME/.dotfiles/tmux/workspaces";
  };


  # Containers: 
  virtualisation = {
    docker = {
      enable = true;
    };
    # oci-containers = {
    #   backend = "docker";

    #   containers = {
    #     Ollama = {
    #       image = "ollama/ollama";
    #       autoStart = true;
    #       ports = ["127.0.0.1:11434:11434"];
    #       environment = {};

    #       mounts = [
    #         {
    #           hostPath = "/var/lib/docker/volumes/ollama/_data";
    #           containerPath = "/root/.ollama";
    #         }
    #       ];
    #       # gpuSupport = true;
    #     };
    #   };
    # };
  };

  # TODO: Is this needed both here and in home.nix?
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
