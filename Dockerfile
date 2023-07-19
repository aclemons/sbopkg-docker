FROM aclemons/slackware:15.0-full@sha256:d4f9ecb4c8ba7b989c000f49bb01c37a585b8074a29e563bddee03fed132bf6e

# hadolint ignore=DL3003
RUN cd /tmp && \
  wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
  installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
  rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
  wget --progress=dot:gig https://slackbuilds.org/GPG-KEY && \
  gpg --import GPG-KEY && \
  rm GPG-KEY

CMD ["su", "-"]
