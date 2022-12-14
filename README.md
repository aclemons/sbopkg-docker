# sbopkg Docker Image

# Quick reference

- **Maintained by**:

  [aclemons](https://github.com/aclemons)

# Supported tags and respective `Dockerfile` links

- [`latest`, `slack-15.0`](https://github.com/aclemons/sbopkg-docker/blob/master/Dockerfile) - latest sbopkg installed on slackware stable
- [`slack-current`](https://github.com/aclemons/sbopkg-docker/blob/master/Dockerfile) - latest sbopkg installed on slackware current

# Quick reference (cont.)

- **Where to file issues**:
  [https://github.com/aclemons/sbopkg-docker/issues](https://github.com/aclemons/sbopkg-docker/issues)

- Supported architectures:
  amd64, armv7, arm64v8, i386 (varies per Slackware release)

# What is sbopkg?

Sbopkg is a command-line and dialog-based tool to synchronize with the SlackBuilds.org ("SBo") repository, a collection of third-party SlackBuild scripts to build Slackware packages.

It is maintained by Willy Sudiarto Raharjo [willysr](https://github.com/willysr).

> [sbopkg](https://github.com/sbopkg/sbopkg)

# How to use

Running sbopkg in a docker image means you always have a clean environment. You probably want to bind mount some directories so that the the output ends up on the host. Something like this should get your started:

```sh
mkdir -p $HOME/sbopkg/{tmp,sbopkg}
docker run --rm -it -v $HOME/sbopkg/sbopkg:/var/lib/sbopkg/ -v $HOME/sbopkg/tmp:/tmp aclemons/sbopkg
```

Then build as your normally would with sbopkg:

```sh
sbopkg
```

If you want to build i586 or arm packages, you can pass `--platform linux/386` or `--platform linux/arm` in your docker run invocation.

When building with a `linux/386` container on an x86\_64 host, you will probably want to invoke sbopkg with `linux32`:

    $ linux32 sbopkg -b mypackage

# License

The Docker image creation scripts contained under the repository sbopkg-docker are licensed under the MIT license.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
