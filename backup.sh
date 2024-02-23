#!/bin/bash

# Define variáveis
backup_files="/home /var/spool/mail /etc /root /boot /opt"
dest="/mnt/backup"
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Mensagem de início
echo "Iniciando backup de $backup_files para $dest/$archive_file"
date
echo

# Executa o backup usando tar
tar czf "$dest/$archive_file" $backup_files || { echo "Erro ao criar o arquivo de backup"; exit 1; }

# Mensagem de conclusão
echo
echo "Backup concluído com sucesso."
date

# Lista os arquivos no diretório de backup para verificar tamanhos
echo
echo "Lista de arquivos no diretório de backup:"
ls -lh "$dest"