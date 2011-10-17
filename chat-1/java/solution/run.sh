#!/bin/sh

java -cp $prefix/lib/java/RSBJava.jar	\
     -jar dist/chat-1.jar					\
     $1
