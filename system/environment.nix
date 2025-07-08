{pkgs, ...}: {
  environment = {
    pathsToLink = [
      "/share/zsh"
      "/share/bash"
      "/share/fish"
      "/share/nushell"
      "/libexec"
    ];

    variables = {
      EDITOR = "vim";
    };

    etc = {
      issue.text = ''
        Welcome to NixOS!

      '';
    };
  };

  environment.systemPackages = with pkgs; [
    bash
    zsh
    fish
    nushell
    curl
    wget
    rsync
    vim
    nano
    zip
    unzip
    gzip
    _7zz-rar
    htop
    btop
    iotop
    lsof
    psmisc
    file
    which
    tree
    fd
    ripgrep
    lshw
    usbutils
    pciutils
    git
    nmap
    netcat
    dig
    fzf
    man-pages
    man-pages-posix
  ];
}
