#!/bin/bash

# Log le début de la recherche
logger -t findme "Searching for FindMe.txt..."

# Rechercher les fichiers FindMe.txt
files_found=$(find /home -type f -name "FindMe.txt")

if [ -z "$files_found" ]; then
    # Si aucun fichier trouvé, log l'absence de fichiers
    logger -t findme "Can't find file. Restarting in 1 minute."
else
    # Si des fichiers sont trouvés, log leur suppression
    for file in $files_found; do
        logger -t findme "Found here: $file"
        rm -f "$file"
        logger -t findme "Deleted $file."
    done
fi
