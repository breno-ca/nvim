(expression_list
  value: (function_call
    name: (dot_index_expression
      field: (identifier) @field
      (#eq? @field "parse_query")
    )
    arguments: (arguments
      (string
        content: (string_content)
      )
      (string
        content: (string_content) @injection.content
        (#set! injection.language "query")
      )
    )
  )
)
