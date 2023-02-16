# TODO
# less dynamic titlebar - don't need current line, col and mode
# plug.kak
# Fuzzy finder
# kakbouard
# Install kak-lsp via plug

colorscheme tomorrow-night

set global autocomplete prompt  # Turn off automatic completion (it's annoying)

eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
lsp-enable


