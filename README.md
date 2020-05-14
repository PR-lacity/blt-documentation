# blt-documentation

If the following error is encountered:

./bltsetup.sh: line #: syntax error near unexpected token `fi'

./bltsetup.sh: line #: `fi'

run
`awk 'BEGIN{RS="^$";ORS="";getline;gsub("\r","");print>ARGV[1]}' bltsetup.sh`

or 

`awk 'BEGIN{RS="^$";ORS="";getline;gsub("\r","");print>ARGV[1]}' oneline.sh`
