;;; SQL Highlight
; In strings
(
  [
    (raw_string_literal)
    (interpreted_string_literal)
  ] @injection.content

  (#offset! @injection.content 0 1 0 -1)
  (#match? @injection.content
    "(SELECT|INSERT|REPLACE|UPDATE|DELETE|WHERE|JOIN).+(FROM|VALUES|SET|ON)?"
  )
  (#set! injection.language "sql")
)

;;; JSON Highlight
; In strings
(
  (expression_list
    (raw_string_literal) @injection.content

    (#match? @injection.content ".*[{\\[\\]}:,\"].*")
    (#set! injection.language "json")
  )
)

;;XML highlight injection for string literals
;(var_declaration
;  (var_spec
;    name: (identifier)
;    type: (type_identifier)
;    value: (expression_list
;      (raw_string_literal) @injection.content
;      (#match? @injection.content ".*<\\?xml.*")
;      (#set! injection.language "xml")
;    )
;  )
;)
