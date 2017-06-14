#!/bin/bash

cmdProxy='command';  
command type -f sudo &> /dev/null && cmdProxy='sudo';

#Creation folder app
mkdir data/

mkdir mongo/
#Création du mdp

rootPasswd="0000"
echo "Mot de passe root:  '${rootPasswd}'" > ./passwdMongoDB.log



${cmdProxy} docker build -f MongoServ -t my_mongo .

${cmdProxy} docker run -v "$(pwd)/mongo":/mongo --name tp_mongo -d my_mongo mongod --smallfiles



#NODE 
${cmdProxy} docker build -f NodeServ -t my_node .

${cmdProxy} docker run -it --name node -v "$(pwd)/data":/data -e "MONGO_URI=mongodb://tp_mongo/keystone" --link tp_mongo -d -p 8082:3000 my_node

