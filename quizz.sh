#!/bin/bash

#################################### PARAMS ###############################################

for arg in $@
do
	if [[ $arg =~ ^-p=([1-9][0-9]*)$ ]]
	then
		nb_players=${BASH_REMATCH[1]}

	fi

	if [[ $arg =~ ^-q=([1-9][0-9]*)$ ]]
	then
		nb_questions=${BASH_REMATCH[1]}

	fi
	
	if [[ $arg =~ ^-t=([0-9]+)$ ]]
        then
                timer=${BASH_REMATCH[1]}

        fi

done

if [ -z $nb_questions ] || [ -z $nb_players ]
then
	echo "Vous devez préciser le nombre de joueurs ET le nombre de questions posées par joueur, lisez le README."
	exit 1
fi

nb_players_conf=$(wc conf/players -l|cut -d" " -f1)

if [ $nb_players_conf -ne $nb_players ]
then
	echo "Problème avec le nombre de joueurs, vérifiez le fichier conf/players."
	exit 1
fi

nb_total=$(($nb_questions * $nb_players))


nb_questions_conf=$(wc conf/questions -l|cut -d" " -f1)

if [ $nb_questions_conf -lt $nb_total ]
then
	echo "Il n'y a pas assez de questions disponibles dans conf/questions avec vos paramètres."
	exit 1
fi


if [ -n $timer ] && ([ $timer -lt 15 ] || [ $timer -gt 60 ])
then
	echo "Pour le confort du jeu, mettez un timer entre 15 et 60 secs."
	exit 1
fi

############################### FIN DES PARAMS ############################################

clear

echo "We're playing with $nb_players players, have fun!"
echo ""
cat conf/players
echo ""
echo "You can exit this quizz by typing ' q ' or ' exit ' instead of an answer."
echo ""
read -p "Press any key to continue : " debut

clear

############################## CREATION DES FICHIERS TEMPORAIRES ##########################


if [ -d tmp ]
then
	rm -r tmp
fi

mkdir tmp 2> /dev/null


######### DETERMINATION ALEATOIRE DE L'ORDRE DE PARTICIPATION DES JOUEURS ##########


player_list=tmp/randomplayers


shuf conf/players --output=$player_list     

for i in $(seq $(($nb_questions - 1)))
do
	shuf conf/players >> $player_list
done


######### EXTRACTION ALEATOIRE DU BON NOMBRE DE QUESTIONS ##########


question_list=tmp/randomquestions


shuf -n $nb_total conf/questions --output=$question_list



##### ATTRIBUTION DE 1 QUESTION PAR JOUEUR #####


for i in $(seq $nb_total)
do

	echo "Question for $(sed -n $i\p $player_list)"
	echo ""
	sed -n $i\p $question_list
	echo ""

		if ! [ -z $timer ]
		then

		bash conf/countdown.sh --$timer

		fi

	read -p "Your answer ? : " answer

	if [[ $answer =~ ^(exit|Exit|EXIT|q|quit|Q|QUIT|Quit)$ ]]

	then
		read -p "Are you sure you wanna quit? (Y/N) : " choix
		
			if [[ $choix =~ ^(Y|O)$ ]]
		then
			echo "End of quizz."
			rm -r tmp
			exit 2
		else
			echo "Resuming game, get ready for next question ..."
			sleep 3
			
		fi
	fi
	clear
done

rm -r tmp

echo "No more questions to ask, the quizz is now over !"
exit 0

