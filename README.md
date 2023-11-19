Script quizz.sh ayant pour but de poser des questions à des joueurs, avec timer.


Pour jouer, suivez les instructions ci-dessous :

1. Editer la liste des joueurs dans le fichier conf/players  (1 joueur = 1 ligne)

2. Lancez le script quizz.sh EN SPECIFIANT les arguments requis

3. Les arguments sont :

	-p=	nombre de joueurs (players)
	-q=	nombre de questions posées par joueur
	-t=	temps de réflexion par question (en secondes)

4. Par exemple : pour 4 joueurs, 2 questions par joueur et un temps de réponse de 20s

	bash quizz.sh -p=4 -q=2 -t=20

5. Le quizz ne se lancera pas s'il n'y a pas assez de questions disponibles dans le fichier conf/questions.

6. Laissez votre imagination faire le reste pour les questions, vous pouvez bien sûr éditer le fichier conf/questions !
