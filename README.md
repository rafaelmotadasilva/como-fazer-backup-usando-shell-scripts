# Como Fazer Backup Usando Shell Scripts

Neste guia, vamos explorar como criar e restaurar backups usando shell scripts no Linux.

## Visão Geral

Em geral, um shell script configura quais diretórios devem ser copiados e passa esses diretórios como argumentos para o utilitário tar, que cria um arquivo compactado.

## Objetivos do Backup

Antes de começarmos, é importante entender por que fazer backups é essencial para a segurança dos dados. Os backups são cruciais para proteger contra perda de dados devido a falhas de hardware, erros humanos, ataques de malware ou outros desastres. Ao automatizar o processo de backup com shell scripts, podemos garantir que nossos dados estejam protegidos de forma eficaz e confiável.

## Requisitos

* Permissões de administrador (sudo).

## Instruções

1. [O shell script](#o-shell-script)
2. [Executando o script](#executando-o-script)
3. [Restaurando arquivos](#restaurando-arquivos)
4. [Conclusão](#conclusão)

## O shell script 

O seguinte shell script usa o comando tar para criar um arquivo compactado em um sistema de arquivos.

```bash
#!/bin/bash

# Define variáveis
backup_files="/home /var/spool/mail /etc /root /boot /opt"
dest="/mnt/backup"
mkdir –p “$dest”
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
```

## Executando o script

A maneira mais simples de usar o script de backup acima é copiar e colar o conteúdo em um arquivo (chamado `backup.sh`, por exemplo). O arquivo deve ser tornado executável:

```
chmod u+x backup.sh
```

Em seguida, em um prompt do terminal, execute o seguinte comando:

```
sudo ./backup.sh
```

Essa é uma ótima maneira de testar o script para garantir que tudo funcione conforme o esperado.

## Restaurando arquivos

Depois de criar um arquivo de backup, é importante testá-lo e, se necessário, restaurar os arquivos.
Aqui estão alguns comandos úteis para essa finalidade:

**Listando o conteúdo do arquivo de backup:** Para ver uma listagem do conteúdo do arquivo de backup, execute o seguinte comando em um terminal:

```
tar -tzvf /mnt/backup/hostname-day.tgz
```

**Restaurando um arquivo do backup:** Para restaurar um arquivo do arquivo de backup para um diretório diferente, utilize o seguinte comando:

```
tar -xzvf /mnt/backup/hostname-day.tgz -C /tmp etc/hosts
```

A opção `-C` do `tar` redireciona os arquivos extraídos para o diretório especificado. O exemplo acima irá extrair o arquivo `/etc/hosts` para `/tmp/etc/hosts`. O `tar` recria a estrutura de diretórios que ele contém.

Para restaurar todos os arquivos do arquivo de backup, utilize o seguinte comando:

```
cd /
sudo tar -xzvf /mnt/backup/hostname-day.tgz
```

**Nota:** Isso substituirá os arquivos atualmente no sistema de arquivos.

## Conclusão

Parabéns! Agora você tem um backup automatizado e confiável. Certifique-se de testá-lo regularmente para evitar surpresas.

## Contribuição

Se você tiver sugestões de melhorias ou correções para este guia, sinta-se à vontade para enviar uma pull request.

## Referências

* Documentação Oficial do Ubuntu: [Como fazer backup usando shell scripts](https://ubuntu.com/server/docs/how-to-back-up-using-shell-scripts)