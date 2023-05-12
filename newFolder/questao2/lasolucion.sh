#!/bin/bash


echo "Enter with the numbar of cycles"
read N
echo "Enter with the numbar of seconds"
read S
echo "Enter with the start user name"
read P_USER

echo "$N $S $P_USER"

for i in {1..$N}
do
	read max_memory mmprocess <<< $(ps -eo user,pcpu,pmem,comm --sort=-pmem | grep -m 1 "$P_USER" | awk '{print $3,$4}')
	read min_memory mnprocess <<< $(ps -eo user,pcpu,pmem,comm --sort=pcpu | grep -m 1 "$P_USER" | awk '{print $3,$4}')
	read max_cpu cpxprocess <<< $(ps -eo user,pcpu,pmem,comm --sort=-pcpu | grep -m 1 "$P_USER" | awk '{print $2,$4}')
	read min_cpu cpnprocess <<< $(ps -eo user,pcpu,pmem,comm --sort=pcpu | grep -m 1 "$P_USER" | awk '{print $2,$4}')
	sleep 5
done

echo "max cpu usage was $max_cpu by the process $cpxprocess"
echo "min cpu usage was $min_cpu by the process $cpnprocess"
echo "max memory usage was $max_memory by the process $mmprocess"
echo "min memory usage was $min_memory by the process $mnprocess"


