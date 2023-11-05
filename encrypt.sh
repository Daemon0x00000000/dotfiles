#!/bin/bash

if [ ! -d "dotfiles" ]; then
  echo "Le dossier 'dotfiles' n'existe pas."
  exit 1
fi

if [ ! -f "pass" ]; then
  echo "Le fichier 'pass' n'existe pas."
  exit 1
fi

archive_name="dotfiles.tar.gz"

tar czf "$archive_name" "dotfiles"
if [ $? -ne 0 ]; then
  echo "Erreur lors de la compression de 'dotfiles'."
  exit 1
fi

ansible-vault encrypt "$archive_name" --vault-password-file "pass"
if [ $? -ne 0 ]; then
  echo "Erreur lors du chiffrement de l'archive."
  exit 1
fi

echo "Chiffrement effectué"
