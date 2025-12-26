**WORKAROUND SHELL FOR RUNNING MONOGAME GAMES ON NIXOS**

This repository provides a minimal `shell.nix` setup to get **MonoGame projects running on NixOS**.

**STUFF I DID OUTSIDE `shell.nix`**

* Installed `freetype` and `libpng` system-wide
* Enabled `nix-ld` for dynamic linking of non-Nix binaries

  ```
  programs.nix-ld.enable = true;
  ```

**TESTED ON**

* NixOS 25.11
* KDE Plasma (X11)
