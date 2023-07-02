FROM aclemons/slackware:15.0-full@sha256:28dc4f1c52b60e7e86e9ac508fb649336c8395cbde25b03f3d30c03166e59d4d

# hadolint ignore=DL3003
RUN cd /tmp && \
  wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
  installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
  rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
  wget --progress=dot:gig https://slackbuilds.org/GPG-KEY && \
  gpg --import GPG-KEY && \
  rm GPG-KEY

CMD ["su", "-"]
