{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [ pkgs.git ];

  languages.python.enable = true;

  # pre-commit.hooks.shellcheck.enable = true;
}
