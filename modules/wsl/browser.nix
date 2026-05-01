{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg.desktopEntries.file-protocol-handler = {
    name = "File Protocol Handler";
    exec = "rundll32.exe url.dll,FileProtocolHandler %u";
    type = "Application";
    noDisplay = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "file-protocol-handler.desktop";
      "x-scheme-handler/https" = "file-protocol-handler.desktop";
      "x-scheme-handler/about" = "file-protocol-handler.desktop";
      "x-scheme-handler/unknown" = "file-protocol-handler.desktop";
      "text/html" = "file-protocol-handler.desktop";
    };
  };
}
