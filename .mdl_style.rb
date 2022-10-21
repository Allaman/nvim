all

# Extend line length, since each sentence should be on a separate line.
rule 'MD013', :line_length => 99999

# allow inline HTML
exclude_rule "MD033"

# First header should be a top level header
exclude_rule "MD002"

# First line in file should be a top level header
exclude_rule "MD041"
