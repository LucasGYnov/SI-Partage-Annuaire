# Projet SI de mise en place d'un serveur de fichiers avec Samba et Webmin

## Contexte Global
Ce projet permet l’évaluation des compétences acquises grâce aux modules de l’UF « Infrastructure & Système d’information ». Pour ce faire, ce projet devra être réalisé en groupe de 2. Vous pouvez soumettre un projet personnel dont le contenu et les fonctionnalités devront être validés par l’établissement. Si vous n’avez pas d’idée de projet, vous avez le choix parmi une liste de projets proposés dans la partie « Projets au choix ».

## Choix du Projet : Partage de Fichiers avec Annuaire
Le projet "Partage Réseau + Annuaire" vise à créer un système de partage de fichiers sécurisé et efficace au sein d'un réseau local. Il a pour but de mettre en place un réseau permettant aux utilisateurs un accès centralisé et contrôlé aux ressources partagées, tout en assurant des sauvegardes régulières des données.


## Utilisation de VMware pour Configurer Ubuntu comme Serveur

### Objectif
Configurer une machine virtuelle avec VMware Workstation sous Linux, en utilisant Ubuntu Server 24.04 pour servir de serveur.


## Installation et Mise en Place de Samba

### Objectif
Utiliser Samba pour partager des fichiers entre différents systèmes d'exploitation au sein d'un réseau local. Samba permet aux systèmes Linux de partager des fichiers et des imprimantes avec des systèmes Windows, en utilisant les protocoles SMB/CIFS.


## Installation et Mise en Place de Webmin

### Objectif
Utiliser Webmin pour administrer le serveur Ubuntu et les services associés, comme Samba, via une interface web graphique. Webmin simplifie la gestion des utilisateurs, des permissions et des configurations de serveur.

## Utilisation avec les Différents Types d'Utilisateurs

### Utilisateur
- Accès aux fichiers publics partagés via Samba.
- Peut lire, écrire et modifier les fichiers dans les répertoires autorisés.

### Administrateur
- Accès complet à tous les fichiers partagés, y compris les répertoires de sauvegarde.
- Peut consulter les sauvegardes automatiques.
- Possibilité d'exécuter des sauvegardes manuelles et de configurer les paramètres de sauvegarde.

## Fonctionnalités de Sauvegarde

### Principe de Sauvegarde Toutes les Heures

Le système de sauvegarde est conçu pour effectuer des sauvegardes automatiques toutes les heures des fichiers situés dans le répertoire public vers un répertoire sécurisé destiné aux administrateurs. Cette automatisation assure que les données critiques sont régulièrement sauvegardées et disponibles en cas de besoin.

### Implémentation du Code de Sauvegarde

```bash
#!/bin/bash

# Chemin vers le répertoire Public et Admin/Backups
SRC_DIR="/SharedFile/Public"
DEST_DIR="/SharedFile/Admin/Backups"

# Timestamp pour le nom des backups avec les deux derniers chiffres de l'année et des /
TIMESTAMP=$(date +"%d-%m-%y_%H:%M")
BACKUP_DIR="$DEST_DIR/Backup-$TIMESTAMP"
LOG_FILE="$BACKUP_DIR/backup.log"

# Print debug information
echo "Debug: SRC_DIR=$SRC_DIR"
echo "Debug: DEST_DIR=$DEST_DIR"
echo "Debug: TIMESTAMP=$TIMESTAMP"
echo "Debug: BACKUP_DIR=$BACKUP_DIR"
echo "Debug: LOG_FILE=$LOG_FILE"

# Créer le répertoire de destination s'il n'existe pas
mkdir -p "$BACKUP_DIR"
echo "Debug: Created backup directory $BACKUP_DIR"

# Copier récursivement tout le contenu du répertoire source vers le répertoire de destination
rsync -av --delete "$SRC_DIR/" "$BACKUP_DIR/"
echo "Debug: Rsync copy completed"

# Générer le fichier de log
echo "Copie de $SRC_DIR à $BACKUP_DIR réussie, $TIMESTAMP" > "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Ajouter l'arborescence du répertoire Public dans le log
echo "Arborescence du répertoire Public :" >> "$LOG_FILE"
tree "$SRC_DIR" >> "$LOG_FILE"

# Print completion message
echo "Debug: Backup script completed"
```

## Autres Fichiers Disponibles

### Code pour la Sauvegarde dans le Dépôt GIT

Le script de sauvegarde et d'autres ressources nécessaires sont disponibles dans le dépôt GIT du projet. Cela facilite la gestion collaborative et permet de tracer les modifications apportées au script de sauvegarde et autres composants du projet.

### Documentation d’Architecture

La documentation d’architecture fournit une vue détaillée de la configuration réseau, de la répartition des services, ainsi que des bonnes pratiques de gestion et de sécurité mises en œuvre dans le cadre du projet. Cette documentation est essentielle pour comprendre l'infrastructure sous-jacente et assurer une gestion efficace du serveur de fichiers avec Samba et Webmin.
