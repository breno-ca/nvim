;CSS highlight injection for string literals
(
  (assignment_expression  
    left: (member_expression
      property: (property_identifier) @css
      (#eq? @css "cssText")
    )
  
    right: (template_string
      (string_fragment) @injection.content
    )
    (#set! injection.language "css")
  )
)

(
  (call_expression
    function: (identifier) @instance
      (#eq? @instance "style")
    arguments: (arguments 
      (template_string
        (string_fragment) @injection.content
        (#set! injection.language "css")
      )
    )
  )
)



;HTML highlight injection for string literals
(
  (assignment_expression 
    left: (member_expression
      property: (property_identifier) @html
      (#eq? @html "innerHTML")
    )
    right: (template_string
      (string_fragment) @injection.content
    )
    (#set! injection.language "html")
  )
)
