FROM aclemons/slackware:15.0-full

# hadolint ignore=DL3003
RUN cd /tmp && \
  wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
  installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
  rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
  wget --progress=dot:gig https://slackbuilds.org/GPG-KEY && \
  gpg --import GPG-KEY && \
  rm GPG-KEY

CMD ["su", "-"]
