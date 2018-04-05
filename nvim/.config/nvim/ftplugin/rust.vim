"deoplete autocompletion
let g:deoplete#sources#rust#racer_binary=globpath("$HOME","/.cargo/bin/racer")
let g:deoplete#sources#rust#rust_source_path=expand("$RUST_SRC_PATH")
let g:deoplete#sources#rust#show_duplicates=1
let g:deoplete#sources#rust#documentation_max_height=20

