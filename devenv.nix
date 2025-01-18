{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [ pkgs.git ];

  languages.python = {
    enable = true;
    venv = {
      enable = true;
      requirements = ''
        mkdocs
      '';
    };
  };

  # pre-commit.hooks.shellcheck.enable = true;
}
