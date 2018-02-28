JAVA_OPTS="-Xms${JVM_MINIMUM_MEMORY:-128m} -Xmx${JVM_MAXIMUM_MEMORY:-512m} ${JVM_SUPPORT_RECOMMENDED_ARGS:-"-Datlassian.plugins.enable.wait=300"} -Dfile.encoding=UTF-8 $JAVA_OPTS"

export JAVA_OPTS

CATALINA_OPTS="-Dcrowd.home=${CROWD_HOME:-/var/atlassian/application-data/crowd} -Dcatalina.connector.scheme=${CATALINA_CONNECTOR_SCHEME:-http} -Dcatalina.connector.secure=${CATALINA_CONNECTOR_SECURE:-false} -Dcatalina.connector.proxyName=${CATALINA_CONNECTOR_PROXYNAME:-} -Dcatalina.connector.proxyPort=${CATALINA_CONNECTOR_PROXYPORT:-} -Dcatalina.context.path=${CATALINA_CONTEXT_PATH:-} $CATALINA_OPTS"

export CATALINA_OPTS

# set the location of the pid file
if [ -z "$CATALINA_PID" ] ; then
    if [ -n "$CATALINA_BASE" ] ; then
        CATALINA_PID="$CATALINA_BASE"/work/catalina.pid
    elif [ -n "$CATALINA_HOME" ] ; then
        CATALINA_PID="$CATALINA_HOME"/work/catalina.pid
    fi
fi
export CATALINA_PID
