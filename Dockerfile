# syntax=docker/dockerfile:1.10.0@sha256:865e5dd094beca432e8c0a1d5e1c465db5f998dca4e439981029b3b81fb39ed5

FROM aclemons/slackware:15.0-full@sha256:bbfc2a9c49fabeabb88f5645411b899c76a7535a808504f2709963e2a1e8c56d

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
    printf "c302e306523b234bb025f1a74ee66d3037cfd25f2cc6ffd5f909e4d6278b5db6  sbopkg-0.38.2-noarch-1_wsr.tgz\n" | sha256sum --strict --check && \
    installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
    rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "D3076BC3E783EE747F09B8B70368EF579C7BA3B6" && \
    gpgconf --kill all

CMD ["su", "-"]
