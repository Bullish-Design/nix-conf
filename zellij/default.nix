{
  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = true;
      tab_bar = true;
      default_layout = "compact";
      theme = "rose-pine";
      themes = {
        "nord" = {
          fg = "#D8DEE9";
          bg = "#2E3440";
          black = "#3B4252";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#81A1C1";
          magenta = "#B48EAD";
          cyan = "#88C0D0";
          white = "#E5E9F0";
          orange = "#D08770";
        };
        "rose-pine" = {
          bg = "#403d52";
          fg = "#e0def4";
          red = "#eb6f92";
          green = "#31748f";
          blue = "#9ccfd8";
          yellow = "#f6c177";
          magenta = "#c4a7e7";
          orange = "#fe640b";
          cyan = "#ebbcba";
          # black = "#26233a";
          black = "#000000";
          white = "#e0def4";
        };
      };
    };
  };
}
