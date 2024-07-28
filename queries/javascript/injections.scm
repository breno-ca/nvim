;CSS highlight injection for string literals
(assignment_expression  
  left: (member_expression
    property: (property_identifier) @property
    (#eq? @property "cssText")
  )

  right: (template_string
    (string_fragment) @injection.content
    (#set! injection.language "css")
  )
)

;HTML highlight injection for string literals
;(assignment_expression  
;  left: (member_expression
;    property: (property_identifier) @property
;    (#eq? @property "innerHTML")
;  )
;
;  right: (template_string
;    (string_fragment) @injection.content
;    (#set! injection.language "html")
;  )
;)
