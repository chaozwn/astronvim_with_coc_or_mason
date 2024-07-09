[
  ","
  ":"
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "{{"
  "}}"
] @punctuation.bracket


; (jinja_expression) @string
; (identifier) @variable.parameter
; (fn_call) @function

[
 (float)
 (integer)
] @number
