;extends

;loads_attribute_json
(call
  function: (attribute
    attribute: (identifier) @_idd (#eq? @_idd "loads"))
    arguments: (argument_list
      (string (string_content) @injection.content (#set! injection.language "json"))))
      
;rst_for_docstring
(function_definition
  (block
  (expression_statement
    (string
        (string_content) @injection.content (#set! injection.language "rst")))))
      
;all_sql
(string 
  (string_content) @injection.content
  (#vim-match? @injection.content "^\w*SELECT|FROM|INNER JOIN|WHERE|CREATE|DROP|TRUNCATE|INSERT|UPDATE|ALTER.*$")
  (#set! injection.language "sql"))

;sql in function
(expression_statement
  (call function: (attribute attribute:
    (identifier) @_method (#any-of? @_method "execute" "executemany" "execute_batch" "mogrify"))
    arguments: (argument_list (string (string_content) @injection.content (#set! injection.language "sql")))))
