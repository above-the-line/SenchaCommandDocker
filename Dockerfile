#Based on IsraelRoldan's docker file
#Avi Michael iteration 1
#01-09-19

FROM openjdk:8-jre-alpine

#required for Sencha Command: Ruby, JRE,
#Extras required for install: wget curl
#Israel Roldan Extras: build-base libstdc++ tzdata bash ttf-dejavu freetype fontconfig
#For Sencha Architect (needed to download EXT-JS packages, install node and npm)
RUN apk update && apk upgrade && apk --update add \
    ruby build-base libstdc++ tzdata bash ttf-dejavu freetype fontconfig wget curl nodejs npm

#Wget flag "-O" output documents to go to standard output instead of to files
#Esentially downloading the long zip filename to a shorter filename called "senchacmd.zip"
#See https://www.sencha.com/products/extjs/cmd-download/ for versions of CMD
#
#chmod +x (or a+x) makes a file executable for all users
RUN wget http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip -O senchacmd.zip \
    && unzip senchacmd.zip && rm senchacmd.zip && chmod +x SenchaCmd-6.7.0.63-linux-amd64.sh


#Quietly installs Sencha Command to directory /opt/Sencha/Cmd/6.7.0.63 accepting all 3rd party software
#Installs third party software: 
#YUI Compressor (BSD licensed)
# PhantomJS (BSD)
# Google Closure Compiler (Apache) (The Closure Compiler is a tool for making JavaScript download and run faster. Instead of compiling from a source language to machine code, it compiles from JavaScript to better JavaScript. It parses your JavaScript, analyzes it, removes dead code and rewrites and minimizes what's left. It also checks syntax, variable references, and types, and warns about common JavaScript pitfalls.)
# Google Open-Vcdiff (Apache) (An encoder/decoder for the VCDIFF (RFC3284) format)
# Mozilla Rhino (MPL) (Rhino is a JavaScript engine written fully in Java and managed by the Mozilla Foundation as open source software. It is separate from the SpiderMonkey engine, which is also developed by Mozilla, but written in C++ and used in Mozilla Firefox.)
# Google GSON (Apache) (Gson is an open-source Java library to serialize and deserialize Java objects to JSON.)
# JANSI (Apache) (Jansi is a java library for generating and interpreting ANSI escape sequences.)
# Ant-contrib (Apache)
# Ant (Apache)
# Apache Velocity (Apache)
# Commons-io (Apache)
# slf4j (MIT)
# Compass (MIT)
# Sass (MIT)
# FSSM (MIT)
# ChunkyPNG (MIT) (Read/write access to PNG images in pure Ruby.)
# BSJSONAdditions (MIT) (A simple JSON parser in Objective-C )
# Reachability (MIT) (You can easily access the top of the screen in Android. Like a iPhone 6 & 6 Plus.)
# Apache Ant for Windows (Apache) (Apache Ant is a software tool for automating software build processes, which originated from the Apache Tomcat project in early 2000. It was a replacement for the Make build tool of Unix, and was created due to a number of problems with Unix's make. )
# phloc-css (Apache) (Java CSS 2 and CSS 3 parser and builder)
# xfiledialog (Apache) (A native Windows filedialog for Java/Swing application)
# 7-Zip (LGPL)
# ES6 Module Loader (MIT)
# systemjs (MIT)
# Node.js (MIT)
# WebKit (LGPL) (WebKit is the web browser engine used by Safari, Mail, App Store, and many other apps on macOS, iOS, and Linux)
# Bouncy Castle (MIT) (Australian Encryption API)
RUN ./SenchaCmd-6.7.0.63-linux-amd64.sh -q -dir /opt/Sencha/Cmd/6.7.0.63 -Dall=true


#Remove Sencha-installer and make sencha app (in installed folder) executable for all users
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh && chmod +x /opt/Sencha/Cmd/6.7.0.63/sencha

#Turn the below on if you want to to use the container as an executable
#
#ENTRYPOINT ["/opt/Sencha/Cmd/6.7.0.63/sencha"]

#Consider adding sencha executable to the execution path so you can just write sencha
#export PATH="$PATH:/path/to/dir"
#ln -s /opt/Sencha/Cmd/6.7.0.63/sencha sencha
#source ~/.profile 







WORKDIR /code