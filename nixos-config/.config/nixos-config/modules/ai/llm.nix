{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.ai.llm;
in
{
  options.my.ai.llm = {
    enable = lib.mkEnableOption "local LLM serving (Ollama) and coding agents";

    models = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "qwen3.8:27b" ];
      example = [
        "qwen3.8:27b"
        "qwen3-coder:30b"
      ];
      description = ''
        Ollama model tags to pull on activation and keep resident.

        Weights go to /var/lib/private/ollama, not the Nix store, so they are
        invisible to `nix-collect-garbage` and have to be removed with
        `ollama rm`. They are also large: qwen3.8:27b is ~17.7 GB and
        qwen3-coder:30b ~18.6 GB, and a rebuild that adds an entry blocks on
        the download before activation finishes.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Tracks unstable: new model architectures usually need a newer llama.cpp
    # than the release branch ships.
    services.ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      loadModels = cfg.models;
    };

    # pi-coding-agent is in modules/packages/base.nix so every host has the CLI
    # whether or not it serves models locally; this module owns the serving side.
  };
}
