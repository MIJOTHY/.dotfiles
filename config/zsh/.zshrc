source $ZDOTDIR/config.zsh

# Tool-specific RCs.
for file in ${ZDOTDIR}/rc.d/rc.*.zsh; do
    source ${file}
done
