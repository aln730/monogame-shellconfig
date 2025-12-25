{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    dotnet-sdk_8
    fontconfig
    freetype
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];

  shellHook = ''
    export FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ 
      pkgs.fontconfig 
      pkgs.freetype 
      pkgs.libGL 
      pkgs.xorg.libX11 
    ]}:$LD_LIBRARY_PATH
    
    echo "environment loaded"
  '';
}
