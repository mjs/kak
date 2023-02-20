# TODO
# Buffer Fuzzy finder

source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "kak-lsp/kak-lsp" do %{
    # Installed kak-lsp binary via brew
    # cargo install --locked --force --path .
    # optional: if you want to use specific language servers
    mkdir -p ~/.config/kak-lsp
    cp -n kak-lsp.toml ~/.config/kak-lsp/
}
lsp-enable
lsp-auto-signature-help-enable
lsp-inlay-diagnostics-enable global
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global user d ':lsp-find-error<ret>' -docstring 'Jump to next diagnostic'
map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

plug "gustavo-hms/luar" %{
    plug "gustavo-hms/peneira" %{
        require-module peneira
        map global user f ':peneira-files<ret>' -docstring 'Find files'
        map global user F ':peneira-local-files<ret>' -docstring 'Find files relative to current buffer'
    }
}

plug "lePerdu/kakboard" %{
    hook global WinCreate .* %{ kakboard-enable; kakboard-disable }
    map global user y ':kakboard-with-push-clipboard y<ret>' -docstring 'Yank to system clipboard'
    map global user p ':kakboard-with-pull-clipboard p<ret>' -docstring 'Paste from system clipboard'
    map global user P ':kakboard-with-pull-clipboard P<ret>' -docstring 'Paste from system clipboard'
}

colorscheme tomorrow-night
set global autocomplete prompt  # Turn off automatic completion (it's annoying)
set global ui_options terminal_enable_mouse=0 terminal_set_title=0

addhl global/ wrap  # Soft wrapping
map global normal = '|fmt -w $kak_opt_autowrap_column<ret>' # Manually wrap

set global grepcmd 'rg --vimgrep'

define-command find -docstring "find files" -params 1 %{ edit %arg{1} }
complete-command find shell-script-candidates %{ fd --type f }

define-command -docstring 'Invoke skim to open a file' -params 0 sk-edit %{
    evaluate-commands %sh{
        file="$(fd --type f |TMUX="${kak_client_env_TMUX}" sk-tmux)"
        if [ -n "$file" ]; then
            printf 'edit "%s"\n' "$file"
        fi
    }
}

define-command -docstring 'Invoke fzf to open a file' -params 0 fzf-edit %{
    evaluate-commands %sh{
        if [ -z "${kak_client_env_TMUX}" ]; then
            printf 'fail "client was not started under tmux"\n'
        else
            file="$(fd --type f |TMUX="${kak_client_env_TMUX}" fzf-tmux -d 15)"
            if [ -n "$file" ]; then
                printf 'edit "%s"\n' "$file"
            fi
        fi
    }
}

