{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;

    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-s";
    # terminal = "kitty";
    # terminal = "tmux-256color";
    keyMode = "vi";

    historyLimit = 100000;

    tmuxp.enable = true;

    plugins = with pkgs.tmuxPlugins;
      [
        better-mouse-mode
        vim-tmux-navigator

        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-powerline true
            set -g @dracula-show-flags true
            set -g @dracula-show-left-icon session

            # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping, ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, playerctl, kubernetes-context, synchronize-panes
            set -g @dracula-plugins "cpu-usage gpu-usage ram-usage"

            # default is 1, it can accept any number and 0 disables padding.
            set -g @dracula-left-icon-padding 2

            set -g @dracula-border-contrast true

            set -g status-position top
          
          '';

        }
        
        yank
        sensible

      ];

    
    extraConfig = ''
      bind-key h select-pane -L #\; resize-pane -R 10
      #bind-key C-h {if -F '#{pane_at_left}' ''' 'select-pane -L ; resize-pane -R 20'}
      bind-key C-j select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l select-pane -R
      set -gq allow-passthrough on
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      
      
      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift vim keys to switch windows
      bind -n S-h previous-window
      bind -n S-l next-window

      # Shift Alt vim keys to resize pane height by 15 lines:
      bind -n M-K resize-pane -U 15
      bind -n M-J resize-pane -D 15
      bind -n M-H resize-pane -L 10
      bind -n M-L resize-pane -R 10

      # Alt vim keys to resize pane height by percentage:
      bind -n M-k resizep -y 80% 
      bind -n M-j resizep -y 20% 
      bind -n C-Down resizep -y 90%
      bind -n C-Up resizep -y 10%
      
      # tmux resizep -y 90%     




    '';


  };

}

