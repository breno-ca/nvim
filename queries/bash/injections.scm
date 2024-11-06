;Bash highlight injection in alias commands
(
  (command
    name: (command_name
      (word) @command_name
    )

    argument: (concatenation
      (raw_string) @injection.content

      (#offset! @injection.content 0 1 0 -1)
      (#set! injection.language "bash")
    )
  )
)
