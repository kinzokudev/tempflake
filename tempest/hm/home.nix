{
  config,
  pkgs,
  userinfo,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "${userinfo.name}";
    homeDirectory = "/home/${userinfo.name}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.11";

    shellAliases = {
      tx = "tmux";
      txn = "tmux new";
      txa = "tmux attach";
      txd = "tmux detach";
      txk = "tmux kill-session";
      txl = "tmux list-sessions";
      dv = "direnv";
      dva = "direnv allow";
      dvs = "direnv status";
      dvk = "direnv revoke";
      dvr = "direnv reload";
      ".." = "cd ..";
      tfmt = "treefmt";
      rb = "sudo nixos-rebuild switch --flake .";
      fu = "sudo nix flake update";
      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";
      lg = "lazygit";
      az = "yazi";
      nf = "neofetch";
      ff = "fastfetch";
      cl = "clear";
      pm = "pulsemixer";
      v = "fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim";
      udm = "udisksctl mount -b";
      udu = "udisksctl unmount -b";
    packages =
      with pkgs;
      [
        btop
        fd
        kubectl
        minikube

        helmfile
        fluxcd
        go-task
        krew
        cilium-cli
        talosctl
        kubeconform
        kustomize
        stern
        minijinja
      ]
      ++ [
        inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.gimp-with-plugins
      ];
    file = {
      ".curlrc".text = ''
        # When following a redirect, automatically set the previous URL as referer.
        referer = ";auto"

        # Retrying
        connect-timeout = 60
        max-time 120
        retry 3
        retry-delay 0
        retry-max-time 60
      '';
      ".gitconfig".text = ''
        [user]
          name = Kira Rene
          email = kira@renec88.xyz
          signingKey = ${config.home.homeDirectory}/.ssh/id_ed25519.pub
        [gpg]
          format = ssh
        [format]
          signOff = true
        [core]
          autocrlf = input
          editor = nvim
          excludesfile = ${config.home.homeDirectory}/.gitignore_global
        [commit]
          gpgSign = true
        [merge]
          ff = only
        [pull]
          rebase = true
        [status]
          submoduleSummary = false
        [tag]
          gpgSign = true
          forceSignAnnotated = true
        [init]
          defaultBranch = main
        [filter "lfs"]
          smudge = git-lfs smudge -- %f
          process = git-lfs filter-process
          required = true
          clean = git-lfs clean -- %f
        [url "ssh://git@github.com/"]
          pushInsteadOf = https://github.com/
        [push]
          autoSetupRemote = true
      '';
      ".gitignore_global".text = ''
        *~
        .DS_Store
        Thumbs.db
        unittest.xml
      '';
    };
  };

  xdg = {
    desktopEntries = {
      "discord-canary" = lib.mkForce {
        name = "Discord Canary";
        type = "Application";
        icon = "discord-canary";
        terminal = false;
        exec = "mullvad-exclude DiscordCanary --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,MiddleClickAutoscroll,UseOzonePlatform --ozone-platform=wayland";
      };
    };
    configFile = {
      "starship.toml".source = ./starship.toml;
    };
  };
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    fish = {
      enable = true;
      shellAbbrs = config.home.shellAliases;
      shellAliases = {
        ls = "eza";
      };
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings

        ${pkgs.fluxcd}/bin/flux completion fish | source
        ${pkgs.talosctl}/bin/talosctl completion fish | source
        ${pkgs.kubectl}/bin/kubectl completion fish | source
        ${pkgs.minikube}/bin/minikube completion fish | source

        # ASDF configuration code
        if test -z $ASDF_DATA_DIR
            set _asdf_shims "$HOME/.asdf/shims"
        else
            set _asdf_shims "$ASDF_DATA_DIR/shims"
        end

        # Do not use fish_add_path (added in Fish 3.2) because it
        # potentially changes the order of items in PATH
        if not contains $_asdf_shims $PATH
            set -gx --prepend PATH $_asdf_shims
        end
        set --erase _asdf_shims

        export GPG_TTY=$(tty)
      '';
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
        {
          name = "fish-kubectl-abbr";
          src = pkgs.fetchFromGitHub {
            owner = "lewisacidic";
            repo = "fish-kubectl-abbr";
            rev = "0.1.0";
            hash = "sha256-x4u8tDuNWMOBFK+5KdF1+k2RJd1vFooRcmEkBXCZZ1M=";
          };
        }
      ];
      functions = {
        "," = ''
          for pkg in $argv
              nix shell nixpkgs#$pkg
          end
        '';
      };
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      mise.enable = true;
    nixcord = {
      enable = true;
      discord = {
        enable = true;
        vencord = {
          enable = false;
          package = pkgs.vencord;
        };
        openASAR.enable = false;
        package = pkgs.discord-canary;
      };
      vesktop = {
        enable = true;
        package = pkgs.vesktop.overrideAttrs (oldAttrs: {
          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "vesktop";
              desktopName = "Discord";
              exec = "mullvad-exclude vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,MiddleClickAutoscroll,UseOzonePlatform --ozone-platform=wayland";
              icon = "discord";
              startupWMClass = "VencordDesktop";
              genericName = "Internet Messenger";
              keywords = [
                "discord"
                "vencord"
                "electron"
                "chat"
              ];
              categories = [
                "Network"
                "InstantMessaging"
                "Chat"
              ];
            })
          ];
        });
      };
      config = {
        themeLinks = [
          "https://raw.githubusercontent.com/ardishco-the-great/catpuccin-discord/main/themes/frappe.theme.css"
        ];
        frameless = false;
        plugins = {
          alwaysTrust.enable = true;
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
          };
          banger.enable = true;
          # betterFolders = {
          #   enable = true;
          #   showFolderIcon = "always";
          # };
          betterGifAltText.enable = true;
          betterGifPicker.enable = true;
          betterNotesBox.enable = true;
          betterRoleDot.enable = true;
          betterUploadButton.enable = true;
          blurNSFW.enable = true;
          # callTimer.enable = true;
          clearURLs.enable = true;
          crashHandler.enable = true;
          dearrow.enable = true;
          emoteCloner.enable = true;
          experiments.enable = true;
          fakeNitro.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          forceOwnerCrown.enable = true;
          friendInvites.enable = true;
          friendsSince.enable = true;
          fullSearchContext.enable = true;
          fixCodeblockGap.enable = true;
          gameActivityToggle.enable = true;
          gifPaste.enable = true;
          imageZoom.enable = true;
          loadingQuotes.enable = true;
          memberCount.enable = true;
          messageClickActions.enable = true;
          messageLogger = {
            enable = true;
            deleteStyle = "text";
            logDeletes = true;
            logEdits = true;
            ignoreSelf = true;
          };
          messageTags.enable = true;
          moreCommands.enable = true;
          moreKaomoji.enable = true;
          mutualGroupDMs.enable = true;
          newGuildSettings.enable = true;
          noBlockedMessages = {
            enable = true;
            ignoreBlockedMessages = true;
          };
          noDevtoolsWarning.enable = true;
          noF1.enable = true;
          noReplyMention = {
            enable = true;
            userList = "";
            shouldPingListed = false;
          };
          noProfileThemes.enable = true;
          noUnblockToJump.enable = true;
          openInApp.enable = true;
          permissionFreeWill.enable = true;
          pictureInPicture.enable = true;
          pinDMs.enable = true;
          plainFolderIcon.enable = true;
          platformIndicators.enable = true;
          previewMessage.enable = true;
          quickMention.enable = true;
          quickReply.enable = true;
          reactErrorDecoder.enable = true;
          relationshipNotifier.enable = true;
          replaceGoogleSearch = {
            enable = true;
          };
          secretRingToneEnabler.enable = true;
          sendTimestamps.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;
          silentTyping.enable = true;
          sortFriendRequests.enable = true;
          spotifyControls.enable = true;
          spotifyCrack.enable = true;
          spotifyShareCommands.enable = true;
          translate.enable = true;
          typingIndicator.enable = true;
          typingTweaks.enable = true;
          unsuppressEmbeds.enable = true;
          userVoiceShow.enable = true;
          USRBG.enable = true;
          vencordToolbox.enable = true;
          viewIcons.enable = true;
          voiceChatDoubleClick.enable = true;
          voiceMessages.enable = true;
          volumeBooster = {
            enable = true;
            multiplier = 5;
          };
          webKeybinds.enable = true;
          webRichPresence.enable = true;
          whoReacted.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
          noTypingAnimation.enable = true;
        };
      };
    };
  };
}
