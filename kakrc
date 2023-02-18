# TODO
# less dynamic titlebar - don't need current line, col and mode
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
set global ui_options terminal_enable_mouse=0
addhl global/ wrap  # Soft wrapping

# Manually wrap
map global normal = '|fmt -w $kak_opt_autowrap_column<ret>'
