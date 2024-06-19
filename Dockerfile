# syntax=docker/dockerfile:1.7.1@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e

FROM aclemons/slackware:15.0-full@sha256:d88933e405b2b272e7da1e20ec1f302f41b16e1fbdcffbb11c5e55f9a11e5dd4

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
    printf "c302e306523b234bb025f1a74ee66d3037cfd25f2cc6ffd5f909e4d6278b5db6  sbopkg-0.38.2-noarch-1_wsr.tgz\n" | sha256sum --strict --check && \
    installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
    rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "D3076BC3E783EE747F09B8B70368EF579C7BA3B6" && \
    gpgconf --kill all

CMD ["su", "-"]
