[
  (self: super:
    with super; {
        my = {
          Firefox = (callPackage ./Firefox.nix {});
          Slack = (callPackage ./Slack.nix {});
        };
    })
]
