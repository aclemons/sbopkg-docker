ARG base_image=aclemons/slackware:15.0-full
# hadolint ignore=DL3006
FROM $base_image

ARG base_image
RUN echo "Using base image $base_image"

# hadolint ignore=DL3003
RUN cd /tmp && \
  wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
  installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
  rm sbopkg-0.38.2-noarch-1_wsr.tgz

