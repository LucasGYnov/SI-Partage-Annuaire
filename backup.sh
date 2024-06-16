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