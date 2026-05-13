# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc


# Ignora maiúsculas/minúsculas no tab completion
bind 'set completion-ignore-case on'

# Mostra candidatos imediatamente sem precisar de 2x Tab
bind 'set show-all-if-ambiguous on'

# Cycle nos candidatos com Tab (como menu do fish)
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'    # Shift+Tab volta

# Seta pra cima/baixo busca no histórico pelo prefixo já digitado
bind '"\e[A":history-search-backward'  # ↑
bind '"\e[B":history-search-forward'   # ↓

# Coloriza a listagem de completions
bind 'set colored-stats on'
bind 'set colored-completion-prefix on'


# Localização varia por distro — ajuste se necessário
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
elif [[ -f ~/.fzf.bash ]]; then
    source ~/.fzf.bash
fi

if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
fi

# Ctrl+R → histórico fuzzy | Ctrl+T → arquivos fuzzy | Alt+C → cd fuzzy
fastfetch
# ── Funções fzf ────────────────────────────────────────────────────────────

fcd() {
    local dir
    dir="$(find "${1:-.}" -type d 2>/dev/null \
        | fzf --preview 'tree -C {} | head -200' \
              --preview-window 'up:60%')" \
    && cd "$dir"
}

fe() {
    local file
    file="$(find "${1:-.}" -type f 2>/dev/null \
        | fzf --preview 'bat --color=always {} 2>/dev/null || cat {}' \
              --preview-window 'up:60%')" \
    && ${EDITOR:-nvim} "$file"
}
# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
