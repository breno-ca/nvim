;;; SQL Highlight
; In strings
(
  [
    (raw_string_literal_content)
    ;(interpreted_string_literal_content)
  ] @injection.content
  ;(#offset! @injection.content 0 1 0 -1)
  (#match? @injection.content
    "(SELECT|INSERT|REPLACE|UPDATE|DELETE|WHERE|JOIN|ORDER).+(FROM|VALUES|SET|ON|BY)?"
  )
  (#set! injection.language "sql")
)

;;; JSON Highlight
; In strings
(
  (raw_string_literal_content) @injection.content

  (#match? @injection.content ".*[{\\[\\]}:,\"].*")
  (#set! injection.language "json")
)

;;; HTTP Highlight
; In strings
(
  (expression_statement
    (call_expression
      function: (selector_expression
        (field_identifier) @field
        (#match? @field "Handle|HandleFunc")
      )
      arguments: (argument_list
        (interpreted_string_literal
          (interpreted_string_literal_content) @injection.content
          (#set! injection.language "http")
        )
      )
    )
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
