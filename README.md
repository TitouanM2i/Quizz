Script quizz.sh ayant pour but de poser des questions à des joueurs, avec possibilité d'ajout d'un timer.

________________________________________________________________________________________________________________________________


Pour jouer, suivez les instructions ci-dessous :

1. Editer la liste des joueurs dans le fichier conf/players  (1 joueur = 1 ligne)

2. Lancez le script quizz.sh EN SPECIFIANT les arguments requis

3. Les arguments sont :

	-p=	nombre de joueurs (players)
	-q=	nombre de questions posées par joueur
	-t=	temps de réflexion par question (en secondes)

4. Par exemple : pour 4 joueurs, 3 questions par joueur et un temps de réponse de 20s

	bash quizz.sh -p=4 -q=3 -t=20

5. Le quizz ne se lancera pas s'il n'y a pas assez de questions disponibles dans le fichier conf/questions.

________________________________________________________________________________________________________________________________


6.1 Pour ajouter des questions, se déplacer dans le dossier conf/Themes, et les rajouter à la suite des listes déjà présentes.

6.2 Vous pouvez également créer votre propre liste dans le dossier ' conf/Themes ' et y écrire vos questions.

7. Pour intégrer vos nouvelles questions au quizz, se déplacer dans le dossier ' conf ' puis exécuter le script ' refresh.sh '

8. Vous pouvez maintenant retourner dans le dossier Quizz et exécuter ' quizz.sh '

________________________________________________________________________________________________________________________________
