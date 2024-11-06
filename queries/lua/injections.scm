(expression_list
  value: (function_call
    name: (dot_index_expression
      field: (identifier) @query_field
      (#eq? @query_field "parse_query")
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

(function_call
  name: (dot_index_expression
    field: (identifier) @cmd_field)
    (#eq? @cmd_field "cmd")
  arguments: (arguments
    (string
      content: (string_content) @injection.content
      (#set! injection.language "vim")
    )
  )
)
