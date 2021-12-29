alias conf="sudo vim /etc/nixos/configuration.nix"
alias xconf="vim ~/.xmonad/xmonad.hs"
alias reb="sudo nixos-rebuild switch"
alias xup="xrdb ~/.Xresources"
alias xreb="cd ~/.xmonad ; nix-shell ; xmonad --rebuild"
alias usbmount="jmtpfs ~/mountpoint"
alias c2n="cabal2nix ./. > "
alias c2nd="nix-shell --packages cabal2nix --run \"cabal2nix .\" > default.nix"
alias hasktags="~/.cabal/bin/hasktags"

#Functions

hstags() {
  ~/.cabal/bin/hasktags -c -f "$1"'/tags' "$1"
}
