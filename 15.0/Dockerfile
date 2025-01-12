# syntax=docker/dockerfile:1.12.1@sha256:93bfd3b68c109427185cd78b4779fc82b484b0b7618e36d0f104d4d801e66d25

FROM aclemons/slackware:15.0-full@sha256:eb98c1e5813138f6ffd7017169e6e8dbd47dcaa4e2021b3e06d125582f59f8b6

ARG TARGETARCH
RUN --mount=type=bind,source=15.0/docker-entrypoint.sh,target=/tmp/docker-entrypoint.sh \
    install -m0755 /tmp/docker-entrypoint.sh /docker-entrypoint.sh && \
    if [ "$TARGETARCH" = "386" ] ; then sed -i 's,exec su,exec /usr/bin/linux32 su,' /docker-entrypoint.sh ; fi

RUN wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
    bash -o pipefail -c 'printf "c302e306523b234bb025f1a74ee66d3037cfd25f2cc6ffd5f909e4d6278b5db6  sbopkg-0.38.2-noarch-1_wsr.tgz\n" | sha256sum --strict --check' && \
    installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
    rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "D3076BC3E783EE747F09B8B70368EF579C7BA3B6" && \
    gpgconf --kill all

ENTRYPOINT ["/docker-entrypoint.sh"]
