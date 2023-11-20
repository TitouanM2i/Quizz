#!/bin/bash

nb_themes=$(($(ls -l Themes |wc -l) -1))
liste_themes=$(ls -l Themes |sed -E "s/ +/ /g" |cut -d" " -f9|tail -$nb_themes)

if [ -f questions ]
then
	rm questions
fi

for file in $liste_themes
do
	cat Themes/$file >> questions
done

echo "Questions list succesfully reloaded."
