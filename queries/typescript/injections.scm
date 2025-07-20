;SQL highlight injection for string literals
(
  (template_string
    (string_fragment) @injection.content
    (#match? @injection.content
      "(CREATE|ALTER|DROP|SELECT|INSERT|REPLACE|UPDATE|DELETE|WHERE|JOIN|ORDER).+(TABLE|FROM|VALUES|SET|ON|BY)?"
    )
    (#set! injection.language "sql")
  )
)
