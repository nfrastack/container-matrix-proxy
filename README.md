# nfrastack/container-matrix-proxy

## About

This repository will build a container to proxy your connections to a Matrix Homeserver, specifically Synapse.

## Maintainer

* [Nfrastack](https://www.nfrastack.com)

## Table of Contents


* [About](#about)
* [Maintainer](#maintainer)
* [Table of Contents](#table-of-contents)
* [Installation](#installation)
  * [Prebuilt Images](#prebuilt-images)
  * [Quick Start](#quick-start)
  * [Persistent Storage](#persistent-storage)
* [Configuration](#configuration)
  * [Environment Variables](#environment-variables)
    * [Base Images used](#base-images-used)
    * [Core Configuration](#core-configuration)
  * [Users and Groups](#users-and-groups)
  * [Networking](#networking)
* [Maintenance](#maintenance)
  * [Shell Access](#shell-access)
* [Support & Maintenance](#support--maintenance)
* [License](#license)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/nfrastack/container-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)
*  Needs access to a Matrix Homeserver
*  Optional access to a Matrix Media Repository

## Installation

### Prebuilt Images

Feature limited builds of the image are available on the [Github Container Registry](https://github.com/nfrastack/container-matrix-proxy/pkgs/container/container-matrix-proxy) and [Docker Hub](https://hub.docker.com/r/nfrastack/matrix-proxy).

To unlock advanced features, one must provide a code to be able to change specific environment variables from defaults. Support the development to gain access to a code.

To get access to the image use your container orchestrator to pull from the following locations:

```
ghcr.io/nfrastack/container-matrix-proxy:(image_tag)
docker.io/nfrastack/matrix-proxy:(image_tag)
```

Image tag syntax is:

`<image>:<optional tag>`

Example:

`ghcr.io/nfrastack/container-matrix-proxy:latest` or

`ghcr.io/nfrastack/container-matrix-proxy:1.0` or

* `latest` will be the most recent commit
* An otpional `tag` may exist that matches the [CHANGELOG](CHANGELOG.md) - These are the safest
* If there are multiple distribution variations it may include a version - see the registry for availability

Have a look at the container registries and see what tags are available.

#### Multi-Architecture Support

Images are built for `amd64` by default, with optional support for `arm64` and other architectures.

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for your use.

* Map persistent storage for access to configuration and data files for backup.
* Set various environment variables to understand the capabilities of this image.

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
| --------- | ----------- |
| `/data`   | Data        |
| `/logs`   | Logs        |

## Configuration

### Environment Variables

#### Base Images used

This image relies on a customized base image in order to work.
Be sure to view the following repositories to understand all the customizable options:

| Image                                                   | Description      |
| ------------------------------------------------------- | ---------------- |
| [OS Base](https://github.com/nfrastack/container-base/) | Base Image       |
| [Nginx](https://github.com/nfrastack/container-nginx/)  | Web Server Image |

Below is the complete list of available options that can be used to customize your installation.

* Variables showing an 'x' under the `Advanced` column can only be set if the containers advanced functionality is enabled.

#### Homeserver Options

| Variable                    | Value                                                               | Default     |
| --------------------------- | ------------------------------------------------------------------- | ----------- |
| `HOMESERVER_TYPE`           | `synapse` only supported at this time                               | `synapse`   |
| `HOMESERVER_URL`            | URL to Matrix Homeserver eg `http://synapse:8008`                   |             |
| `ENABLE_SYNAPSE_ADMIN`      | Create proxy to Synapse Administration API                          | `FALSE`     |
| `SYNAPSE_ADMIN_ALLOWED_IPS` | IP/Networks allowed to access Synapse Admin API seperated by commas | `0.0.0.0/0` |

#### Matrix Authentication Service Proxy Options

| Variable           | Value                                                                     | Default |
| ------------------ | ------------------------------------------------------------------------- | ------- |
| `ENABLE_PROXY_MAS` | Create proxy to Matrix Authentication Servicethird party media repository | `FALSE` |
| `MAS_URL`          | URL to Media Repository eg `http://mas:8080`                              |         |

#### Media Proxy Options

| Variable                  | Value                                                                       | Default |
| ------------------------- | --------------------------------------------------------------------------- | ------- |
| `ENABLE_PROXY_MEDIA_REPO` | Create proxy to third party media repository                                | `FALSE` |
| `MEDIA_REPO_URL`          | URL to Media Repository eg `http://media-repo:8000`                         |         |
| `MEDIA_REPO_PROXY_LOGOUT` | Send Client logout requests to `MEDIA_REPO_URL` instead of `HOMESERVER_URL` | `TRUE`  |

#### Well Known Options

| Variable            | Value                                                     | Default |
| ------------------- | --------------------------------------------------------- | ------- |
| `ENABLE_WELL_KNOWN` | Enable serving .well-known/matrix/server and client files | `FALSE` |
| `WELL_KNOWN_CLIENT` | Homeserver base url eg `https://matrix.example.com`       |         |
| `WELL_KNOWN_SERVER` | Homeserver server info eg `matrix.example.com:443`        |         |

* * *

## Maintenance

### Shell Access

For debugging and maintenance, `bash` and `sh` are available in the container.

## Support & Maintenance

* For community help, tips, and community discussions, visit the Discussions board.
* For personalized support or a support agreement, see Nfrastack Support.
* To report bugs, submit a Bug Report. Usage questions will be closed as not-a-bug.
* Feature requests are welcome, but not guaranteed. For prioritized development, consider a support agreement.
* Updates are best-effort, with priority given to active production use and support agreements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
