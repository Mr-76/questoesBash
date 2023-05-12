#bin/bash



declare -A tcp_dict udp_dict

lsof -a -i4 -i6 -itcp -iudp | awk '{print $1,$8}' > out.txt
max_udp='none'
max_tcp='none'
max_ntcp=0
max_nudp=0

#Simplesmente pega o numero de conect tcl do comando se for maior que o anterior é armazenado
#depois eh so printar
#lembrando que o | pipezao cria uno subshell chato que nao deixa vc usar os valores fora do loop
#entao usa as chaves '{}' para rodar o comando e ainda assim usar as variaveis quando o loop acaba
#mais sobre :----http://mywiki.wooledge.org/BashFAQ/024
cat out.txt | sort | uniq -c | awk '{print $1,$2,$3}' |{
	while read count command protocol; do

	if [[ "$protocol" == "TCP" ]]; then
		if [[ $max_ntcp < $count ]]; then
			max_ntcp=$command
		else
			continue
		fi
	elif [[ "$protocol" == "UDP" ]]; then
		if [[ $max_nudp < $count ]]; then
			max_nudp=$command
		else
			continue
		fi
	fi

done
echo "====== TOP ====="
echo -e "TOP conexões UDP:\n * $max_nudp"
echo -e "TOP conexões TCP:\n * $max_ntcp"
}
