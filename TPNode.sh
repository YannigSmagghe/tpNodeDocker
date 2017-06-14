#!/bin/bash

cmdProxy='command';  
command type -f sudo &> /dev/null && cmdProxy='sudo';

#Creation folder app
mkdir data/

mkdir mongo/
#Création du mdp

rootPasswd="0000"
echo "Mot de passe root:  '${rootPasswd}'" > ./passwdMongoDB.log



${cmdProxy} docker build -f MongoServ -t mongo .

${cmdProxy} docker run -v "$(pwd)/mongo":/mongo --name mongo -d mongo mongod --smallfiles



#NODE 
${cmdProxy} docker build -f NodeServ -t node .

${cmdProxy} docker run -it --name node -v "$(pwd)/data":/data --link mongo:mongo -d -p 8082:3000 node bash

