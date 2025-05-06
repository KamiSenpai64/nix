{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "daniel"; # Change to your username
  home.homeDirectory = "/home"; # Change to your home directory

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # CLI tools
    bat # Better cat
    exa # Better ls
    ripgrep # Better grep
    fd # Better find
    btop # Better top
    neofetch # System info
    ranger # File manager
    tmux # Terminal multiplexer
    jq # JSON processor
    
    # Communication
    discord
  ];

  # Configure Git
  programs.git = {
    enable = true;
    userName = "KamiSenpai64"; # Change this
    userEmail = "miuletdaniel@gmail.com"; # Change this
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  # Configure Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set cursorline
    '';
  };

  # Configure Kitty terminal
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      copy_on_select = "clipboard";
      window_padding_width = 5;
    };
  };

  # Configure ZSH with Oh-My-Zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "history" "colored-man-pages" "command-not-found" ];
      theme = "robbyrussell";
    };
    
    shellAliases = {
      ll = "exa -l --icons";
      la = "exa -la --icons";
      lt = "exa -T --icons";
      cat = "bat";
      top = "btop";
      vim = "nvim";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
    
    initExtra = ''
      # Additional ZSH configuration here
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
    '';
  };

  # Configure i3wm
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4"; # Windows/Super key
      terminal = "kitty";
      menu = "rofi -show drun";
      
      bars = [
        {
          position = "top";
          statusCommand = "i3status";
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
            size = 10.0;
          };
        }
      ];
      
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
      in {
        "${modifier}+Return" = "exec kitty";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec rofi -show drun";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
        "${modifier}+l" = "exec i3lock -c 000000";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        "Print" = "exec flameshot gui";
      };
      
      startup = [
        { command = "nitrogen --restore"; notification = false; }
        { command = "picom -b"; notification = false; }
        { command = "nm-applet"; notification = false; }
      ];
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";
}
