#!/bin/bash

fichier_html="galerie.html"

if [ -n "$1" ]
then
	fichier_html="$1"
fi

if [ ! -e miniatures ]
then
	mkdir miniatures
fi

echo "<!DOCTYPE html>
  <html>
   <head>
       <title>Ma galerie</title>
       <meta charset=\"utf-8\" />
   </head>
   <body>
      <p>" > $fichier_html

for fichier in *.jpeg *.jpg *.png *.bmp
do
	convert "$fichier" -thumbnail 50x50^ miniatures/"$fichier"
	echo "        <a href=\"$fichier\"><img src=\"miniatures/$fichier\" alt=\"$fichier\" /></a>" >> $fichier_html
done

echo "      </p> 
    </body>
  </html>" >> $fichier_html