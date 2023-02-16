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

plug "gustavo-hms/luar" %{
    plug "gustavo-hms/peneira" %{
        require-module peneira
        map global user f ':peneira-files<ret>'
        map global user F ':peneira-local-files<ret>'
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
