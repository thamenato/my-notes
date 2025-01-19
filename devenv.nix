{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [
    pkgs.act
  ];

  languages.python = {
    enable = true;
    venv = {
      enable = true;
      requirements = ''
        mkdocs
        mkdocs-terminal
      '';
    };
  };

  git-hooks.hooks = {
    end-of-file-fixer.enable = true;
    mkdocs-linkcheck.enable = true;
    markdownlint.enable = true;
    check-yaml.enable = true;
    yamllint.enable = true;
  };

}
