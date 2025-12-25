{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    dotnet-sdk_8
    fontconfig
    freetype
    libpng
    libGL
    SDL2
    openal
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    gdb
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib:${pkgs.lib.makeLibraryPath [
      pkgs.libGL
      pkgs.SDL2
      pkgs.openal
      pkgs.freetype
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXrandr
    ]}:$LD_LIBRARY_PATH"

    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf

    #failsafe
    export LIBGL_ALWAYS_INDIRECT=1

    echo "environment loaded!"
  '';
}
