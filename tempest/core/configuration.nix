# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  userinfo,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  services = {
    blueman.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      allowSFTP = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    fwupd.enable = true;

    mullvad-vpn.enable = true;

    twingate.enable = true;
  };
  networking = {
    hostName = "TEMPEST"; # Define your hostname.
    nameservers = [
      "192.168.40.20"
      "1.1.1.1"
      "1.0.0.1"
    ];
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo = {
    extraRules = [
      {
        users = [ "kinzoku" ];
        commands = [
          {
            command = "ALL";
            options = [
              "SETENV"
              "NOPASSWD"
            ];
          }
        ];
      }
    ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      ${userinfo.name} = {
        isNormalUser = true;
        description = "Kira Rene";
        extraGroups = [
          "networkmanager"
          "wheel"
          "qemu-libvirtd"
          "libvirtd"
          "disk"
        ];
        packages = with pkgs; [
          kdePackages.kate
        ];
        ignoreShellProgramCheck = true;
        openssh.authorizedKeys.keys = lib.nebula.getSSHPubkeyList userinfo.handles.github "1wyfkvdg85m8q1ba583bif5sjhjkgibi8h8hsmzw5bk1w1qgv37z";
      };
      root = {
        ignoreShellProgramCheck = true;
        openssh.authorizedKeys.keys = lib.nebula.getSSHPubkeyList userinfo.handles.github "1wyfkvdg85m8q1ba583bif5sjhjkgibi8h8hsmzw5bk1w1qgv37z";
      };
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs =
            pkgs: with pkgs; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
            ];
        };
      };
    };
    overlays = [
      (_final: prev: {
        steam = prev.steam.override (
          {
            extraLibraries ? _pkgs': [ ],
            ...
          }:
          {
            extraLibraries = pkgs': (extraLibraries pkgs') ++ [ pkgs'.gperftools ];
          }
        );
      })
    ];
  };
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      git
      neovim
      wget
      discord-canary
      libreoffice
      prismlauncher
      vscodium
      feishin
      obsidian
      jetbrains.idea-community
      gcc

      lua-language-server
      typescript-language-server
      vscode-langservers-extracted
      nil
      eslint
      ruff
      ruff-lsp
      pyright
      jdt-language-server
      kotlin-language-server
      editorconfig-checker
      black
      gdtoolkit_4
      gofumpt
      gotools
      golines
      hclfmt
      isort
      ktlint
      markdownlint-cli
      mdformat
      nixfmt-rfc-style
      pgformatter
      prettierd
      rustywind
      shfmt
      python312Packages.sqlfmt
      treefmt
      yamlfix
      golangci-lint
      tfsec
      dotenv-linter
      yamllint
      statix
      deadnix
      yaml-language-server
      gopls
      emmet-ls

      tmux

      thunderbird

      signal-desktop

      wl-clipboard

      dmidecode
      lazygit

      handbrake
      libjxl
      resvg
      vips
      libheif
      calibre
      pandoc
      graphicsmagick
      inkscape
      assimp
      ffmpeg

      fastfetch

      ripgrep

      mullvad-vpn

      kitty
      nmap
      inetutils

      twingate

      jdk17

      mangareader

      pulsemixer

      unzip

      zoxide
      thefuck
      tldr
      scc
      eza
      duf
      aria2
      bat
      diff-so-fancy
      entr
      exiftool
      fdupes
      hyperfine
      just
      jq
      yq-go
      xq-xml
      tomlq
      more
      procs
      rip2
      rsync
      sd
      tre-command
      bandwhich
      btop
      glances
      gping
      dua
      speedtest-cli
      dogdns
      buku
      khal
      neomutt
      newsboat
      rclone
      httpie
      ctop
      lazydocker
      podman-compose
      podman-tui
      dive
      kdash
      asdf-vm
      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components;
        [
          gke-gcloud-auth-plugin
        ]
      ))

      virt-manager

      grc

      nfs-utils

      terraform
      terraform-ls
      gh

      nodePackages_latest.nodejs
      go
      python3

      monero-gui
      monero-cli

      restic

      nix-init
      nix-update
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji

    # (nerdfonts.override {
    #   fonts = [
    #     "JetBrainsMono"
    #     "NerdFontsSymbolsOnly"
    #   ];
    # })
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    geist-font
  ];

  programs = {

    # Install firefox.
    firefox.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    noisetorch.enable = true;
    nix-ld.enable = true;

    ssh = {
      extraConfig = ''
        LogLevel ERROR

        Host *
          AddKeysToAgent yes
          IdentityFile ~/.ssh/id_ed25519

        Host 192.168.*.*
          StrictHostKeyChecking no
          UserKnownHostsFile /dev/null
        Host 172.16.*.*
          StrictHostKeyChecking no
          UserKnownHostsFile /dev/null
        Host 10.*.*.*
          StrictHostKeyChecking no
          UserKnownHostsFile /dev/null
      '';
    };
  };

  virtualisation = {
    waydroid.enable = true;
    libvirtd = {
      enable = true;
      extraConfig = ''
        user="kinzoku"
      '';

      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 kinzoku qemu-libvirtd -"
    "f /dev/shm/scream 0660 kinzoku qemu-libvirtd -"

    # cleanup nixpkgs-review cache on boot
    "D! ${config.hm.xdg.cacheHome}/nixpkgs-review 1755 ${userinfo.name} users 5d"
    # cleanup channels so nix stops complaining
    "D! /nix/var/nix/profiles/per-user/root 1755 root root 1d"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix =
    let
      nixPath = [
        "nixpkgs=flake:nixpkgs"
      ];
    in
    {
      channel.enable = false;
      inherit nixPath;
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
      package = pkgs.lixPackageSets.latest.lix;
      registry = {
        n.flake = inputs.nixpkgs;
        master = {
          from = {
            type = "indirect";
            id = "nixpkgs-master";
          };
          to = {
            type = "github";
            owner = "NixOS";
            repo = "nixpkgs";
          };
        };
        stable.flake = inputs.nixpkgs-stable;
      };
      settings = {
        auto-optimise-store = true;
        nix-path = nixPath;
        warn-dirty = false;
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        cores = 6;
        max-jobs = 8;
      };
    };

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
