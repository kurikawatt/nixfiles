{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.me) services host;
in 
lib.mkIf services.ollama.enable {
  services.ollama = {
    enable = true;
    package = 
      if host.gpuType == "nvidia" then pkgs.ollama-cuda 
      else if host.gpuType == "amd" then pkgs.ollama-vulkan
      else pkgs.ollama-cpu;
    loadModels = [
      "codeqwen:latest"
    ];
  };
}