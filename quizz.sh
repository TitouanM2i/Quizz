#!/bin/bash



for arg in $@
do
	if [[ $arg =~ ^-p=([0-9]+)$ ]]
	then
		nb_players=${BASH_REMATCH[1]}

	fi

	if [[ $arg =~ ^-q=([0-9])$ ]]
	then
		nb_questions=${BASH_REMATCH[1]}

	fi
	
	if [[ $arg =~ ^-t=([0-9]+)$ ]]
        then
                timer=${BASH_REMATCH[1]}

        fi

done

if [ -z $timer ] || [ -z $nb_questions ] || [ -z $nb_players ]
then
	echo "Vous devez spécifier tous les arguments, dans les bons formats, lisez le README"
	exit 1
fi

nb_players_conf=$(wc conf/players -l|cut -d" " -f1)

if [ $nb_players_conf -ne $nb_players ]
then
	echo "Problème avec le nombre de joueurs, vérifiez le fichier conf/players."
	exit 1
fi

nb_questions_conf=$(wc conf/questions -l|cut -d" " -f1)

if [ $nb_questions_conf -lt $(($nb_questions * $nb_players)) ]
then
	echo "Il n'y a pas assez de questions disponibles dans conf/questions avec vos paramètres."
	exit 1
fi

if [ $timer -lt 15 ] || [ $timer -gt 45 ]
then
	echo "Pour le confort du jeu, mettre un timer entre 15 et 45 secs."
	exit 1
fi

echo "We're playing with $nb_players players, have fun!"


if [ -d tmp ]
then
	rm -r tmp
fi

mkdir tmp 2> /dev/null


playerlist=tmp/new_list



shuf conf/players --output=$playerlist


for i in $(seq $(($nb_questions - 1)))
do
	shuf conf/players >> $playerlist
done

cat $playerlist

