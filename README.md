# Docker Image Packaging for Atlassian Crowd

<img src="/alvistack.svg" width="75" alt="AlviStack">

[![GitLab pipeline status](https://img.shields.io/gitlab/pipeline/alvistack/docker-crowd/master)](https://gitlab.com/alvistack/docker-crowd/-/pipelines)
[![GitHub tag](https://img.shields.io/github/tag/alvistack/docker-crowd.svg)](https://github.com/alvistack/docker-crowd/tags)
[![GitHub license](https://img.shields.io/github/license/alvistack/docker-crowd.svg)](https://github.com/alvistack/docker-crowd/blob/master/LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/alvistack/crowd-5.0.svg)](https://hub.docker.com/r/alvistack/crowd-5.0)

Crowd is where you manage users from multiple directories - Active Directory, LDAP, Crowd - via a single admin console, and control application permissions from the same place.

Learn more about Crowd: <https://www.atlassian.com/software/crowd>

## Supported Tags and Respective Packer Template Links

  - [`alvistack/crowd-5.0`](https://hub.docker.com/r/alvistack/crowd-5.0)
      - [`packer/docker-5.0/packer.json`](https://github.com/alvistack/docker-crowd/blob/master/packer/docker-5.0/packer.json)
  - [`alvistack/crowd-4.4`](https://hub.docker.com/r/alvistack/crowd-4.4)
      - [`packer/docker-4.4/packer.json`](https://github.com/alvistack/docker-crowd/blob/master/packer/docker-4.4/packer.json)

## Overview

This Docker container makes it easy to get an instance of Crowd up and running.

Based on [Official Ubuntu Docker Image](https://hub.docker.com/_/ubuntu/) with some minor hack:

  - Packaging by Packer Docker builder and Ansible provisioner in single layer
  - Handle `ENTRYPOINT` with [catatonit](https://github.com/openSUSE/catatonit)

### Quick Start

For the `CROWD_HOME` directory that is used to store the repository data (amongst other things) we recommend mounting a host directory as a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#/data-volumes), or via a named volume if using a docker version \>= 1.9.

Volume permission is NOT managed by entry scripts. To get started you can use a data volume, or named volumes.

Start Atlassian Crowd Server:

    # Pull latest image
    docker pull alvistack/crowd-5.0
    
    # Run as detach
    docker run \
        -itd \
        --name crowd \
        --publish 8095:8095 \
        --volume /var/atlassian/application-data/crowd:/var/atlassian/application-data/crowd \
        alvistack/crowd-5.0

**Success**. Crowd is now available on <http://localhost:8095>

Please ensure your container has the necessary resources allocated to it. We recommend 2GiB of memory allocated to accommodate both the application server and the git processes. See [Supported Platforms](https://confluence.atlassian.com/display/Crowd/Supported+Platforms) for further information.

## Upgrade

To upgrade to a more recent version of Crowd Server you can simply stop the Crowd container and start a new one based on a more recent image:

    docker stop crowd
    docker rm crowd
    docker run ... (see above)

As your data is stored in the data volume directory on the host, it will still be available after the upgrade.

Note: Please make sure that you don't accidentally remove the crowd container and its volumes using the -v option.

## Backup

For evaluations you can use the built-in database that will store its files in the Crowd Server home directory. In that case it is sufficient to create a backup archive of the directory on the host that is used as a volume (`/var/atlassian/application-data/crowd` in the example above).

## Versioning

### `YYYYMMDD.Y.Z`

Release tags could be find from [GitHub Release](https://github.com/alvistack/docker-crowd/tags) of this repository. Thus using these tags will ensure you are running the most up to date stable version of this image.

### `YYYYMMDD.0.0`

Version tags ended with `.0.0` are rolling release rebuild by [GitLab pipeline](https://gitlab.com/alvistack/docker-crowd/-/pipelines) in weekly basis. Thus using these tags will ensure you are running the latest packages provided by the base image project.

## License

  - Code released under [Apache License 2.0](LICENSE)
  - Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

## Author Information

  - Wong Hoi Sing Edison
      - <https://twitter.com/hswong3i>
      - <https://github.com/hswong3i>
