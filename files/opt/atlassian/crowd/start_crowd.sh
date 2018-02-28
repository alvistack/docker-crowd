#!/bin/bash

# resolve links - $0 may be a softlink
PRG="$0"
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`/"$link"
    fi
done
PRGDIR=`dirname "$PRG"`

PRGRUNMODE=false
if [ "$1" = "-fg" ] || [ "$1" = "run" ]  ; then
    shift
    PRGRUNMODE=true
else
    echo "To run Crowd in the foreground, start the server with $0 -fg"
fi

if [ "$PRGRUNMODE" == "true" ] ; then
    exec $PRGDIR/apache-tomcat/bin/catalina.sh run "$@"
else
    exec $PRGDIR/apache-tomcat/bin/startup.sh "$@"
fi
