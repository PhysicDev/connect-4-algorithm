==================================================CONNECT 4==================================================

ce programme est une réplique du jeu du puissance 4 avec un algorithme de type minimax ( https://fr.wikipedia.org/wiki/Algorithme_minimax )

rapel des règles du puissance 4 :
	les joueurs doivent chacun leur tour faire tomber un bille dans la grille,
	le premier joueur à aligner 4 billes ( en ligne , en collone ou en diagonale) a gagné.

utilisation : 
	le bouton new game permet de reset la grille
	le bouton PVP permet de changer le nombre de joueurs:
		(PVP : player vs player
		|PVE : player vs entity(IA 2)
		|IA ; IA 1 vs IA 2 )
	les deux sliders permettent de changer l'intelligence des IA (l'IA 1 joue les verts et l'IA 2 joue les rouges )
	niveau 0 : joue aléatoirement
	niveau 1 : prévoit son prochain coup puis le prochain coup de l'adversaire (2 coups)
	niveau 2 : prévoit ses deux prochains coups et les deux prochains coups de l'adversaire (4 coups)
	niveau 3 : prévoit ses trois prochains coups et les trois prochains coups de l'adversaire (6 coups)
	niveau 4 : prévoit ses quatre prochains coups et les quatre prochains coups de l'adversaire (8 coups)

Ce programme a été réalisé en Java à l'aide processing ( https://processing.org/ ).
les polices d'écriture viennent du site https://www.dafont.com/fr/

les icônes et l'intégralité du programme a été fait par Physic Gamer .
merci d'indiquer que j'en suis le créateur si vous souhaitez réutiliser mon programme.

=================================Physic Gamer || Connect 4 algo || brain factory©=================================
