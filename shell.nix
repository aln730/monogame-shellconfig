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
    icu
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
      pkgs.libpng
      pkgs.icu
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXrandr
    ]}:$LD_LIBRARY_PATH"

    # export for font setup (failsafe for freetype, partially)
    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf

    # failsafe for if OpenGL is a bitch
    export LIBGL_ALWAYS_SOFTWARE=1
    export SDL_VIDEODRIVER=x11

    # cursed symlinking, im sorry but it works
    mkdir -p .lib-scripts
    ln -sf ${pkgs.freetype}/lib/libfreetype.so .lib-scripts/libfreetype6.so
    ln -sf ${pkgs.freetype}/lib/libfreetype.so .lib-scripts/freetype6.so
    ln -sf ${pkgs.libpng}/lib/libpng16.so .lib-scripts/libpng16.so.16
    
    export LD_LIBRARY_PATH="$(pwd)/.lib-scripts:$LD_LIBRARY_PATH"

    echo "environment loaded..."
  '';
}
