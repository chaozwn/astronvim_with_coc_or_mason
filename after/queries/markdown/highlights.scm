;; extends
((inline) @_inline (#match? @_inline "^\(import\|export\)")) @nospell

; offset and table chars courtesy of `megalithic`:
; https://github.com/megalithic/dotfiles/blob/39aa5fcefaa4d68cce66b6de425311e47c2d54fb/config/nvim/after/queries/markdown/highlights.scm#L45-L64

; list markers/bullet points
(
  ([
    (list_marker_star)
    (list_marker_plus)
    (list_marker_minus)
  ]) @markdown_list_marker
  (#offset! @markdown_list_marker 0 0 0 -1)
  (#set! conceal "•")
)

; checkboxes
((task_list_marker_unchecked) @markdown_check_undone (#set! conceal "󰄱"))
((task_list_marker_checked) @markdown_check_done (#set! conceal "󰄵"))

; box drawing characters for tables
(pipe_table_header ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_row ("|") @punctuation.special @conceal (#set! conceal "│"))
(pipe_table_delimiter_cell ("-") @punctuation.special @conceal (#set! conceal "─"))
(pipe_table_row ("|") @punctuation.special @conceal (#set! conceal "│"))

; block quotes
((block_quote_marker) @markdown_quote_marker (#set! conceal "▍"))
((block_quote
  (paragraph (inline
    (block_continuation) @markdown_quote_marker (#set! conceal "▍")
  ))
))

; (fenced_code_block
;   (info_string) @devicon
;   (#as_devicon! @devicon))

(
  fenced_code_block (fenced_code_block_delimiter) @markdown_code_block_marker
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_javascript
  (#any-of? @markdown_code_block_lang_javascript "javascript" "js" "node")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_typescript
  (#any-of? @markdown_code_block_lang_typescript "typescript" "ts")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_json
  (#any-of? @markdown_code_block_lang_json "json" "jsonc")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_bash
  (#any-of? @markdown_code_block_lang_bash "bash" "sh" "shell" "zsh")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_julia
  (#eq? @markdown_code_block_lang_julia "julia")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_lua
  (#eq? @markdown_code_block_lang_lua "lua")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_python
  (#any-of? @markdown_code_block_lang_python "python" "python3")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_diff
  (#eq? @markdown_code_block_lang_diff "diff")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_vim
  (#eq? @markdown_code_block_lang_vim "vim")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_md
  (#any-of? @markdown_code_block_lang_md "markdown" "md" "pandoc")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_yaml
  (#any-of? @markdown_code_block_lang_yaml "yaml" "yml")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_toml
  (#eq? @markdown_code_block_lang_toml "toml")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_java
  (#eq? @markdown_code_block_lang_java "java")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_html
  (#eq? @markdown_code_block_lang_html "xhtml")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_css
  (#eq? @markdown_code_block_lang_css "css")
  (#set! conceal "")
)
(
  [(info_string (language))] @markdown_code_block_lang_sql
  (#eq? @markdown_code_block_lang_sql "sql")
  (#set! conceal "")
)
