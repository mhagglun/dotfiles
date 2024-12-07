; extends

(
    [
        (string_content) @injection.content
    ]
    (#match? @injection.content "(SELECT|INSERT|UPDATE|DELETE).+(FROM|INTO|VALUES|SET).*(WHERE|GROUP BY)?")
    (#set! injection.language "sql")
)

(
    expression_statement (
        call function: (attribute attribute: (identifier) @_method (#any-of? @_method "execute" "executemany" "execute_batch" "mogrify"))
        arguments: (argument_list (string (string_content) @injection.content (#set! injection.language "sql")))
    )
)

(
    [
        (string_content) @injection.content
    ]
    (#match? @injection.content "(CREATE|ALTER|DROP|TRUNCATE).+(TABLE)?")
    (#set! injection.language "sql")
)
