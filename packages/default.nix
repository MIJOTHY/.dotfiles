[
  (self: super:
    with super; {
        my = {
          Firefox = (callPackage ./Firefox.nix {});
          Slack = (callPackage ./Slack.nix {});
          iTerm2 = (callPackage ./iTerm2.nix {});
          gimp = (callPackage ./gimp.nix {});
        };
    })
]
