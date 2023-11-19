#!/bin/bash

#################################### PARAMS ###############################################

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

nb_total=$(($nb_questions * $nb_players))


nb_questions_conf=$(wc conf/questions -l|cut -d" " -f1)

if [ $nb_questions_conf -lt $nb_total ]
then
	echo "Il n'y a pas assez de questions disponibles dans conf/questions avec vos paramètres."
	exit 1
fi

if [ $timer -lt 15 ] || [ $timer -gt 45 ]
then
	echo "Pour le confort du jeu, mettre un timer entre 15 et 45 secs."
	exit 1
fi

############################### FIN DES PARAMS ############################################



echo "We're playing with $nb_players players, have fun!"


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

#cat $player_list


######### EXTRACTION ALEATOIRE DU BON NOMBRE DE QUESTIONS ##########


question_list=tmp/randomquestions


shuf -n $nb_total conf/questions --output=$question_list



##### ATTRIBUTION DE 1 QUESTION PAR JOUEUR #####

choix2=false



for i in $(seq $nb_total)
do
	echo "Question pour : $(sed -n $i\p $player_list)"
	echo ""
	sed -n $i\p $question_list
	echo ""


	read -p "Appuyez sur Entrée pour continuer (exit pour quitter) : " choix

	if [[ $choix =~ ^(exit|Exit|EXIT)$ ]]
	then
		read -p "Voulez-vous vraiment quitter (Y/n) ? " choix2
		if [[ $choix2 =~ ^(|Y|Yes|yes|Oui|oui|O|o)$ ]]
		then
			echo "Fin de partie."
			exit 2
		else
			"Reprise de la partie avec la question suivante..."
			
		fi
	fi
	clear
done


















