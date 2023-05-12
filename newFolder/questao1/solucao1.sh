gzip -dk jan_95.txt.gz
cat jan_95.txt | grep "local - -" > locais.txt && cat jan_95.txt | grep "remote - -" > remotas.txt  
echo "Numero de remotas  $(wc -l < locais.txt | grep -o "[0-9]*")"
echo "Numero de remotas  $(wc -l < remotas.txt | grep -o "[0-9]*")"
rm *.txt


