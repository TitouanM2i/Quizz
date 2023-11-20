#!/bin/bash

nb_themes=$(($(ls -l Themes | wc -l) -1))
liste_themes=$(ls -l Themes|sed -E "s/_+/_/g" |cut -d" " -f10|tail -$nb_themes)

for file in $liste_themes
do
	cat Themes/$file >> liste
done

cat liste
