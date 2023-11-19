#!bin/bash

#commentaire

for arg in $@
do
	if [[ $arg =~ ^--([1-9][0-9]*$) ]]
	then
		timer=${BASH_REMATCH[1]}
	fi
done

for i in $(seq $timer)
do

	echo $((timer-i + 1))
	sleep 1
	if [ $i -eq $timer ]
	then
		clear
		echo "TIME'S UP !!"
	fi
	i=$((i+1))
done
