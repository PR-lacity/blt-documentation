# blt-documentation

If the following error is encountered:

./bltsetup.sh: line 68: syntax error near unexpected token `fi'

./bltsetup.sh: line 68: `fi'

run
`awk 'BEGIN{RS="^$";ORS="";getline;gsub("\r","");print>ARGV[1]}' bltsetup.sh`
