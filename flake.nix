{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    devenv.url = "github:cachix/devenv";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.2";
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shadower = {
      url = "github:n3oney/shadower";
    };
    wayfreeze = {
      url = "github:jappie3/wayfreeze";
    };
    watershot = {
      url = "github:Kirottu/watershot";
    };
    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
    };
    disko = {
      url = "github:ardishko/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    tag-studio = {
      url = "github:TagStudioDev/TagStudio";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dolphin-emu = {
    #   url = "github:MatthewCroughan/dolphin-emu-nix";
    # };
    polly-mc = {
      url = "github:fn2006/PollyMC";
    };
    flux = {
      url = "github:IogaMaster/flux";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minegrub-theme = {
      url = "github:Lxtharia/minegrub-theme";
    };
    catpuccin-cursors = {
      url = "github:catppuccin/cursors";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
    };
    hyprswitch = {
      url = "github:H3rmt/hyprswitch/release";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      treefmt-nix,
      ...
    }:
    let
      inherit (self) outputs;
      libPre = nixpkgs.lib // home-manager.lib;
      lib = import ./lib { inherit libPre inputs; };

      userinfo = {
        name = "kinzoku";
        email = "kinzoku@the-nebula.xyz";
        altemail = "kinzokudev4869@gmail.com";
        timezone = "America/New_York";
        handles = {
          github = "kinzokudev";
          discord = "kinzokudev";
          reddit = "kinzokudev";
          twitter = "kinzokudev";
          bluesky = "kinzokudev";
        };
      };
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      treefmtEval = forEachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      # mkNixosConfiguration =
      #   hostname: system:
      #   lib.nixosSystem (
      #     let
      #       specialArgs = {
      #         inherit
      #           self
      #           inputs
      #           hostname
      #           userinfo
      #           ;
      #       };
      #     in
      #     {
      #       pkgs = import nixpkgs {
      #         inherit system;
      #         config.allowUnfree = true;
      #       };
      #
      #       inherit specialArgs;
      #
      #       modules = [
      #         ./hosts/${lib.toLower hostname}
      #         ./core
      #         # ./overlays
      #         inputs.home-manager.nixosModules.home-manager
      #         {
      #           home-manager = {
      #             useGlobalPkgs = true;
      #             useUserPackages = true;
      #
      #             extraSpecialArgs = specialArgs;
      #
      #             users.${userinfo.name} = {
      #               imports = [
      #                 inputs.nix-index-database.hmModules.nix-index
      #                 ./hosts/${lib.toLower hostname}/home.nix
      #                 ./hm
      #               ];
      #             };
      #           };
      #         }
      #         (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" userinfo.name ])
      #         # inputs.impermanence.nixosModules.impermanence
      #         inputs.sops-nix.nixosModules.sops
      #       ];
      #     }
      #   );
    in
    {
      inherit lib userinfo;
      devShells = forEachSystem (pkgs: {
        default = import ./devshell.nix {
          inherit inputs pkgs;
        };
      });

      formatter = forEachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      checks = forEachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs inputs lib; });

      nixosConfigurations = {
        "TEMPEST" = lib.nixosSystem (
          let
            hostname = "TEMPEST";
          in
          {
            system = "x86_64-linux";
            specialArgs = {
              inherit
                inputs
                outputs
                userinfo
                hostname
                ;
            };
            modules = [
              ./tempest/core
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  extraSpecialArgs = {
                    inherit
                      inputs
                      outputs
                      userinfo
                      hostname
                      ;
                  };

                  # users = {
                  #   # Import your home-manager configuration
                  #   ${userinfo.name} = import ./hm;
                  # };
                  users.${userinfo.name} = {
                    imports = [
                      inputs.nix-index-database.hmModules.nix-index
                      ./tempest/hm
                    ];
                  };
                  backupFileExtension = "backup";
                };
              }
              # alias for home-manager
              (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" userinfo.name ])

              # inputs.impermanence.nixosModules.impermanence
              # inputs.sops-nix.nixosModules.sops
            ];
          }
        );
        # "TEMPEST" = mkNixosConfiguration "TEMPEST" "x86_64-linux";
      };
    };
}
