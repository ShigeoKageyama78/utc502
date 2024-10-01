# Étapes pour installer et démarrer le service FindMe

# 1. Cloner le dépôt Git
git clone https://github.com/ShigeoKageyama78/utc502-findme.git
cd utc502-findme

# 2. Créer le script findme.sh et le copier dans /usr/local/bin/
sudo tee /usr/local/bin/findme.sh > /dev/null <<'EOF'
#!/bin/bash
# findme.sh : Recherche et supprime les fichiers nommés FindMe.txt dans les répertoires utilisateurs.

echo "Searching for FindMe.txt..."
FILES=$(find /home -type f -name "FindMe.txt")
if [ -z "$FILES" ]; then
  echo "Can't find file. Restarting in 1 minute."
else
  for file in $FILES; do
    echo "Found here: $file"
    rm "$file"
    echo "Deleted $file."
  done
fi
EOF

# Rendre le script exécutable
sudo chmod +x /usr/local/bin/findme.sh

# 3. Créer le fichier de service findme.service dans /etc/systemd/system/
sudo tee /etc/systemd/system/findme.service > /dev/null <<'EOF'
[Unit]
Description=FindMe Service - Search and delete FindMe.txt files
After=network.target

[Service]
ExecStart=/usr/local/bin/findme.sh
User=root
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
EOF

# 4. Activer le service au démarrage de l'OS
sudo systemctl enable findme.service

# 5. Démarrer le service
sudo systemctl start findme.service

# 6. Vérifier que le service fonctionne correctement
journalctl -u findme.service -f

# Vous devriez voir des logs indiquant que le script recherche et supprime les fichiers FindMe.txt toutes les minutes.
