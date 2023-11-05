#!/bin/bash

if [ ! -f "dotfiles.tar.gz" ]; then
  echo "Le fichier 'dotfiles.tar.gz' n'existe pas."
  exit 1
fi

if [ ! -f "pass" ]; then
  echo "Le fichier 'pass' n'existe pas."
  exit 1
fi

ansible-vault decrypt "dotfiles.tar.gz" --vault-password-file "pass"
if [ $? -ne 0 ]; then
  echo "Erreur lors du déchiffrement de l'archive."
  exit 1
fi

tar xzf "dotfiles.tar.gz"
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'extraction de l'archive."
  exit 1
fi

stow dotfiles
if [ $? -ne 0 ]; then
  echo "Erreur lors de l'utilisation de stow pour déployer les dotfiles."
  exit 1
fi

echo "Extraction et déploiement avec succès."

