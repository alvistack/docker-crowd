Docker Image Packaging for Atlassian Crowd
==========================================

[![Travis](https://img.shields.io/travis/alvistack/docker-crowd.svg)](https://travis-ci.org/alvistack/docker-crowd)
[![GitHub release](https://img.shields.io/github/release/alvistack/docker-crowd.svg)](https://github.com/alvistack/docker-crowd/releases)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-crowd.svg)](https://github.com/alvistack/docker-crowd/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/docker-crowd.svg)](https://hub.docker.com/r/alvistack/docker-crowd/)

Crowd is where you manage users from multiple directories - Active Directory, LDAP, Crowd - via a single admin console, and control application permissions from the same place.

Learn more about Crowd: <https://www.atlassian.com/software/crowd>

Overview
--------

This Docker container makes it easy to get an instance of Crowd up and running.

### Quick Start

For the `CROWD_HOME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version &gt;= 1.9.

Volume permission is managed by entry scripts. To get started you can use a data volume, or named volumes.

Start Atlassian Crowd Server:

    # Pull latest image
    docker pull alvistack/docker-crowd

    # Run as detach
    docker run \
        -itd \
        --name crowd \
        --publish 8095:8095 \
        --volume /var/atlassian/application-data/crowd:/var/atlassian/application-data/crowd \
        alvistack/docker-crowd

**Success**. Crowd is now available on <http://localhost:8095>

Please ensure your container has the necessary resources allocated to it. We recommend 2GiB of memory allocated to accommodate both the application server and the git processes. See [Supported Platforms](https://confluence.atlassian.com/display/Crowd/Supported+Platforms) for further information.

### Memory / Heap Size

If you need to override Crowd's default memory allocation, you can control the minimum heap (Xms) and maximum heap (Xmx) via the below environment variables.

#### JVM\_MINIMUM\_MEMORY

The minimum heap size of the JVM

Default: `128m`

#### JVM\_MAXIMUM\_MEMORY

The maximum heap size of the JVM

Default: `512m`

### Reverse Proxy Settings

If Crowd is run behind a reverse proxy server, then you need to specify extra options to make Crowd aware of the setup. They can be controlled via the below environment variables.

#### CATALINA\_CONNECTOR\_PROXYNAME

The reverse proxy's fully qualified hostname.

Default: *NONE*

#### CATALINA\_CONNECTOR\_PROXYPORT

The reverse proxy's port number via which Crowd is accessed.

Default: *NONE*

#### CATALINA\_CONNECTOR\_SCHEME

The protocol via which Crowd is accessed.

Default: `http`

#### CATALINA\_CONNECTOR\_SECURE

Set 'true' if CATALINA\_CONNECTOR\_SCHEME is 'https'.

Default: `false`

#### CATALINA\_CONTEXT\_PATH

The context path via which Crowd is accessed.

Default: *NONE*

### JVM configuration

If you need to pass additional JVM arguments to Crowd such as specifying a custom trust store, you can add them via the below environment variable

#### JVM\_SUPPORT\_RECOMMENDED\_ARGS

Additional JVM arguments for Crowd

Default: `-Datlassian.plugins.enable.wait=300`

Upgrade
-------

To upgrade to a more recent version of Crowd Server you can simply stop the Crowd
container and start a new one based on a more recent image:

    docker stop crowd
    docker rm crowd
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will still
be available after the upgrade.

Note: Please make sure that you don't accidentally remove the crowd container and its volumes using the -v option.

Backup
------

For evaluations you can use the built-in database that will store its files in the Crowd Server home directory. In that case it is sufficient to create a backup archive of the directory on the host that is used as a volume (`/var/atlassian/application-data/crowd` in the example above).

Versioning
----------

The `latest` tag matches the most recent version of this repository. Thus using `alvistack/docker-crowd:latest` or `alvistack/docker-crowd` will ensure you are running the most up to date version of this image.

License
-------

-   Code released under [Apache License 2.0](LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <https://twitter.com/hswong3i>
    -   <https://github.com/hswong3i>

