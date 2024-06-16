# Projet de Mise en Place d'un Serveur de Fichiers avec Samba et Webmin

## Introduction
Ce projet vise à configurer un serveur de fichiers sous Ubuntu, en utilisant Samba pour le partage de fichiers et Webmin pour la gestion. Le serveur sera configuré pour permettre la sauvegarde automatique des données, la gestion centralisée des utilisateurs, et une administration simplifiée via une interface web.

## Contenu du Projet

### 1. Installation de la Machine Virtuelle (VM)

#### Objectif
Configurer une machine virtuelle avec VMware Workstation sous Linux, en utilisant Ubuntu Server 24.04 pour servir de serveur.

#### Commandes
```sh
# Téléchargement de l'ISO d'Ubuntu Server
# Création et configuration de la VM
# Installation d’Ubuntu Server
2. Configuration du Réseau
Objectif
Configurer le réseau de la VM pour permettre la communication entre la VM et les autres machines du réseau local.

Commandes
sh
Copier le code
# Vérification des adresses IP
ipconfig (Windows)
sudo apt-get install net-tools
ifconfig (Linux)

# Test de communication
ping <IP_Ubuntu> (Depuis Windows)
ping <IP_Windows> (Depuis Linux)

# Configuration du réseau en mode Bridge
# Allez dans les paramètres de la VM et sélectionnez "Bridged: Connected directly to the physical network"
3. Installation et Configuration de Samba
Objectif
Installer Samba pour permettre le partage de fichiers entre systèmes Unix/Linux et Windows.

Commandes
sh
Copier le code
# Vérification des mises à jour Ubuntu
sudo apt update && sudo apt upgrade -y

# Installation de Samba
sudo apt install samba -y

# Création des répertoires de partage
sudo mkdir -p /SharedFile/Public
sudo mkdir -p /SharedFile/Admin/Backups

# Configuration de Samba
sudo nano /etc/samba/smb.conf

# Ajout des utilisateurs Samba
sudo smbpasswd -a <nom_utilisateur>

# Redémarrage des services Samba
sudo systemctl restart smbd nmbd
4. Installation et Configuration de Webmin
Objectif
Installer Webmin pour administrer le serveur via une interface web.

Commandes
sh
Copier le code
# Installation des dépendances
sudo apt install software-properties-common apt-transport-https wget -y

# Téléchargement et ajout de la clé GPG de Webmin
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -

# Ajout du dépôt Webmin
sudo add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"

# Mise à jour des paquets et installation de Webmin
sudo apt update
sudo apt install webmin -y

# Vérification du statut du service Webmin
sudo systemctl status webmin.service

# Configuration du pare-feu pour permettre l'accès à Webmin
sudo ufw status
sudo ufw allow 10000
sudo ufw allow OpenSSH
sudo ufw enable
5. Utilisation du Serveur
Connexion à Webmin
Accédez à Webmin via un navigateur à l'adresse suivante : https://<adresse_du_serveur>:10000. Utilisez les identifiants d'un utilisateur ayant les privilèges administratifs.

Gestion des Utilisateurs et des Groupes
Ajoutez des utilisateurs et des groupes via l'interface Webmin pour gérer les accès et les permissions des fichiers partagés.

6. Sauvegarde Automatique des Données
Objectif
Mettre en place un système de sauvegarde automatique pour les données du répertoire partagé.

Commandes
sh
Copier le code
# Création d'un lien symbolique
ln -s /shareFile ~/shareFile

# Modification des permissions
sudo chown -R admin:admin /shareFile
sudo chmod -R 555 /shareFile

# Installation de tree pour visualiser les sauvegardes
sudo apt-get install tree

# Création d'un script de sauvegarde
nano /home/admin/ShareDoc/backup.sh

# Rendre le script exécutable
chmod +x /home/admin/ShareDoc/backup.sh

# Configuration de la crontab pour automatiser les sauvegardes
crontab -e
0 * * * * /home/admin/ShareDoc/backup.sh
7. Vérification et Configuration du Pare-feu
Objectif
Vérifier les règles du pare-feu et s'assurer que les connexions Samba sont autorisées.

Commandes
sh
Copier le code
# Vérification des règles du pare-feu
sudo ufw status

# Autorisation des connexions Samba
sudo ufw allow Samba

# Redémarrage du serveur si nécessaire
sudo reboot
Conclusion
Ce projet permet de configurer un serveur de fichiers performant et sécurisé, avec une gestion simplifiée grâce à Webmin. Les étapes détaillées et les commandes fournies garantissent une mise en œuvre efficace et reproductible.