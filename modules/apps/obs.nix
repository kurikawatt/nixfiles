{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf (config.me.host.desktop != "none") {
  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = (config.me.host.gpuType == "nvidia");
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ]
    ++ (if (config.me.host.gpuType == "amd") then [ obs-vaapi ] else []);
  };
}