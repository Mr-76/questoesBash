#bin/bash

declare -A tcp_dict udp_dict

lsof -a -i4 -i6 -itcp -iudp | awk '{print $1,$8}' > out.txt


#Cria um dic com comando como key e o count como valor, tentei mas como vai criando subsheels com o pipe nao tem como pegar
#os valores fora do loop :)
cat out.txt | sort | uniq -c | awk '{print $1,$2,$3}' | while read count command protocol; do
    # Increment the count for the appropriate dictionary key
    #echo "$count $command $protocol" 
    lecommand=$command
    leprotocol=$protocol
    lecount=$count
    if [[ "$protocol" == "TCP" ]]; then
        tcp_dict[$lecommand]=$lecount
	echo "firefox has ${tcp_dict['firefox']}" 
    elif [[ "$protocol" == "UDP" ]]; then
        udp_dict[$lecommand]=$lecount
    fi
done


echo " firefox has ${tcp_dict['firefox']}" 
echo " firefox has ${tcp_dict['firefox']}" 

#echo " le key value par ${udp_dict[$lecommand]}"

echo "Starting loop"
# Print the results
# For every key in the associative array..
for KEY in "${!tcp_dict[@]}"; do
  # Print the KEY value
  echo "Key: $KEY"
  # Print the VALUE attached to that KEY
  echo "Value: ${tcp_dict[$KEY]}"
done
