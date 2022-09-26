#!/usr/bin/bash

diretorios=(publico adm ven sec)

grupos=(GRP_ADM GRP_VEN GRP_SEC)
users_GRP_ADM=(carlos maria joao)
users_GRP_VEN=(debora sebastiana roberto)
users_GRP_SEC=(josefina amanda rogerio)

echo "Criando diretórios"

for diretorio in ${diretorios[@]}; do
    if [[ -d $diretorio ]]
    then
        echo "O diretório $diretorio já existe!"
    else
        mkdir /$diretorio
    fi
    
done

echo "Criando grupos"

for grupo in ${grupos[@]}; do
    if [ $(getent group $grupo) ]
    then
        echo "o grupo $grupo já existe"
    else
        groupadd $grupo
    fi
done

echo "Criando usuários"

for grupo in ${grupos[@]}; do
    users="users_$grupo[@]"
    for usuario in "${!users}"; do
        if [ $(getent passwd $usuario) ]
        then
            echo "O usuário $usuario já existe"
        else
            useradd $usuario -m -s /bin/bash -p $(openssl -crypt Senha123) -G $grupo
        fi
    done
done

echo "Alterando as permissões de cada diretório"

chgrp GRP_ADM /adm
chgrp GRP_VEN /ven
chgrp GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Encerrado"