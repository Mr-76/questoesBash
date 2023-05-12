
#!/bin/bash
echo "input the password"
read pass

#contar numero total de itens no password
count=$(echo "$pass" | wc -m)
#diminuindo 1, ta contando o newline :()
count=$((count - 1))
#contando o numero de letraz uppercase
countUppper=$(echo "$pass" | grep -o '[A-Z]' | wc -l)
#contando o numero de NUMEROS :L
countNumber=$(echo "$pass" | grep -o '[0-9]' | wc -l)

#condicoes para verificacao
if [ $count -ge 8 ]
then
        if [ $countUppper -ge 1 ]
        then
                if [ $countNumber -ge 1 ]
                then
                        echo "good password"
                else
                        echo "need number"
                fi
        else
                echo "need upper case char"
        fi
else
        echo "need more than 8 chars/number/etc"
fi

