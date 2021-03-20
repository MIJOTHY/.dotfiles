# jimbob's .dotfiles

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
