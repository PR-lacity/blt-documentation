# blt-documentation

Updated to add PHP version selection.


## Troubleshooting:


### Unexpected token \`fi'

If the following error is encountered:
```
./bltsetup.sh: line #: syntax error near unexpected token `fi'

./bltsetup.sh: line #: `fi'
```
run the following and replace SCRIPT.sh with the script being run:   
```
awk 'BEGIN{RS="^$";ORS="";getline;gsub("\r","");print>ARGV[1]}' SCRIPT.sh
```

***

### /bin/bash^M: bad interpreter

If the following error is encountered:
```
-bash: ./oneline.sh: /bin/bash^M: bad interpreter: No such file or directory
```
run the following and replace SCRIPT.sh with the script being run:   
```
sed -i -e 's/\r$//' SCRIPT.sh
```

## Post script procedure

After script finishes running, restart WSL userspace by running the following from an administrative powershell
```
Get-Service LxssManager | Restart-Service
```
