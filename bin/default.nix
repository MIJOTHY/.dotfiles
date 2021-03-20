_: super:
{
  binCommon = (super.callPackage ./lib/common.nix {});
  vid-to-gif = (super.callPackage ./media/vid-to-gif.nix {});
  cdr = (super.callPackage ./media/vid-to-gif.nix {});
}
