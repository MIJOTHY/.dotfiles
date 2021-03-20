# jimbob's .dotfiles

## Steps
1. install nix (nix-base/examples/onboarding/nix.sh)
2. add nix to your `/etc/zshrc`
```sh
cat <<EOF | sudo tee -a /etc/zshrc
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
EOF
```
2. Log out and back in
3. Enable the experimental features
```sh
cat <<EOF | sudo tee -a /etc/nix/nix.conf
experimental-features = nix-command flakes
EOF
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
mkdir -p ~/.config/nix
cat <<EOF | tee -a ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```
3. `nix-shell` - this'll drop you into a nix-shell with the nixFlakes nixpkgs
4. `nix build .#darwinConfigurations.james-macbook.system`
   - this'll build the nix-darwin+home-manager config
5. `darwin-rebuild --flake .`

## Tools used
[nix-darwin](https://daiderd.com/nix-darwin): system-level configuration  
[home-manager](https://github.com/rycee/home-manager): user-level configuration  

## Inspiration repos
https://github.com/martinbaillie/dotfiles  
https://github.com/hlissner/dotfiles  
https://github.com/jwiegley/nix-config  
https://github.com/eqyiel  

# TODO:
### Refactor
- [ ] make use of homebrew functionality (https://github.com/LnL7/nix-darwin/pull/262) 
### Docs
- [ ] document architecture
- [ ] inspiration repos
- [ ] steps to bootstrap
- [ ] why

### Architecture 
- [ ] pull together the darwin desktop stuff  
- [ ] why doesn't `skhd` get dumped into the user binaries?  
- [ ] decide more concretely what is config and what is a module  
- [ ] test bootstrapping  

### Infra
- [ ] CI  
- [ ] repo for `.private` stuff  
- [ ] use separate disk for `/Applications` indexing

### desktop
- [ ] configure skhd app-opening with variables available to nix  
- [ ] reload skhd   
- [ ] fix yabai opacity on mode-switch

### ops
- [ ] activate it

### editors
- [ ] put editor dependencies in their derivations

and many more...
