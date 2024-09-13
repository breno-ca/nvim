;SQL highlight injection for string literals
(call_expression
  function: (selector_expression
    field: (field_identifier) @field
    (#eq? @field "Prepare")
  )

  arguments: (argument_list
    (raw_string_literal) @injection.content 
    (#set! injection.language "sql")
  )
)

;XML highlight injection for string literals
(var_declaration 
  (var_spec 
    name: (identifier) 
    type: (type_identifier) 
    value: (expression_list 
      (raw_string_literal) @injection.content
      (#match? @injection.content ".*<\\?xml.*")
      (#set! injection.language "xml")
    )
  )
)

;JSON highlight injection for string literals
;(keyed_element
;  (literal_element
;    (raw_string_literal) @injection.content
;    (#match? @injection.content ".*[{\\[\\]}:,\"].*")
;    (#set! injection.content "json")
;  )
;)

