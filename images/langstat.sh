#NAME
#langstat - donne le nombre de lignes utilisant chaque lettre de l'alphabet dans le fichier, triés par nombre d'occurences décroissant
#SYNOPSIS
#./langstat.sh FILE [OPTION]
#OPTIONS
#-c : donne le nombre de consonnes et de voyelles dans le fichier à la place

#!/bin/bash


if [ $# -ge 1 ] && [ -f $1 ]; then #s'il y a au moins un paramètre et que le 1er paramètre est un fichier qui existe

	if [ $# -gt 1 ] && [ $2 = '-c' ]; then #s'il y a au moins 2 paramètres et que le deuxième est -c
		#egrep à la place de grep pour utiliser une expression régulière, -o pour créer une liste des caractères trouvés (une occurence par ligne), puis on compte ce nombre de lignes avec wc -l (ce qui permet d'avoir non pas le onmbre de mots utilisant une voyelle, mais vraiment le nombre total de voyelles)
		occurences="Voyelles - `egrep 'A|E|I|O|U|Y' -io $1 | wc -l`"
		occurences="$occurences
Consonnes - `egrep 'B|C|D|F|G|H|J|K|L|M|N|P|Q|R|S|T|V|W|X|Z' -io $1 | wc -l`"
		sort -nrk3 <<< $occurences
	else
		alphabet=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
		for lettre in ${alphabet[*]}
		do
		#Je crée une chaine à laquelle j'ajoute, pour chaque lettre de l'alphabet, son nombre d'occurences obtenu avec un grep (recherche) avec -c pour compter et -i pour ignore-case
			occurences_lettres="$occurences_lettres
$lettre - `grep $lettre -ic $1`"
		done
		
		#n pour trier des nombres, r pour ordre inverse, k3 pour prendre troisième colonne (celle des occurences), <<< ("here string") pour mettre une variable chaine de caractères en entrée d'une commande
		sort -nrk3 <<< $occurences_lettres
	fi
else
	echo "Veuillez renseigner le fichier dictionnaire à traiter."
fi
