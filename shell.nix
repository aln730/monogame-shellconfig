{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    dotnet-sdk_8
    fontconfig
    freetype
    libpng      
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ 
      pkgs.fontconfig 
      pkgs.freetype 
      pkgs.libpng 
      pkgs.libGL 
      pkgs.xorg.libX11 
    ]}"
    #I know thatthis is fcking cursed.
    mkdir -p .lib-scripts
    ln -sf ${pkgs.freetype}/lib/libfreetype.so .lib-scripts/libfreetype6.so
    ln -sf ${pkgs.freetype}/lib/libfreetype.so .lib-scripts/freetype6.so
    export LD_LIBRARY_PATH="$(pwd)/.lib-scripts:$LD_LIBRARY_PATH"

    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
    
    echo "environment loaded!"
  '';
}
