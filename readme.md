To use this Dockerfile you need a licenced version of ExtJS - only 6.2 is available for free online.
Available with trial version of Architect.

A rough setup guide might go like follows:

1. Run dockerfile image

2. Mount bind volumes for SDKs and for code output folder

docker container run -d -it --name SenchaCmd --mount type=bind,source="C:\\sencha\sdks",target="/sdk" --mount type=bind,source="C:\\coding\cmd_output_folder",target="/code" sencha-cmd-openjdk-8-jre-alpine

3. Create free sencha account and login to NPM from within the container


4. npm login --registry=https://npm.sencha.com --scope=@sencha
username provided from sencha  name..gmail.com   (.. replaces @)
password provided from sencha


5. Log into the container and bootstrap the project from the SDK
docker container exec -it  

5.a) Consider adding sencha executable to the execution path so you can just write sencha
export PATH="$PATH:/path/to/dir"
ln -s /opt/Sencha/Cmd/6.5.3.6/sencha sencha
source ~/.profile 

(If you don't add it to the execution path
you will have to call sencha comand with /opt/Sencha/Cmd/6.5.3.6/sencha instead of
"sencha" 
i.e. /opt/Sencha/Cmd/6.5.3.6/sencha config --prop sencha.sdk.path=/sdk --save

5.b) specify SDK location as a Sencha Command variable
CMD instructions at https://docs.sencha.com/cmd/6.6.0/guides/extjs/cmd_app.html
sencha config --prop sencha.sdk.path=/sdk --save   (specifies location of SDKs)
sencha -sdk /path/to/ext6 generate app MyApp /path/to/my-app   (bootstrap app)
sencha -sdk C:\Sencha\sdks\ext-7.0.0\ext-7.0.0.156 generate app MyApp C:\coding\sencha-cmd-7-extjs7-test

6. INSIDE CONTAINER get the particular sdk location (bind mount folder)
CONTAINER:: /sdk/
HOST:: C:\Sencha\sdks\

7. INSIDE CONTAINER go to sencha command folder location (ignore if you folled 5.a) 


8. Create a new folder in the code output location (the bind mount folder)
cd code
mkdir myApp

9. Create sencha app 
sencha app init --frameworks="/sdk" --ext="/sdk/6.2.0" --modern myApp


https://docs.sencha.com/cmd/6.6.0/guides/extjs/cmd_app.html
