FROM aclemons/slackware:15.0-full@sha256:6a6a0c1a81e10aff96086ef4e792839e61367633dff637c42ab708e01fb26323

# hadolint ignore=DL3003
RUN cd /tmp && \
  wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
  installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
  rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
  wget --progress=dot:gig https://slackbuilds.org/GPG-KEY && \
  gpg --import GPG-KEY && \
  rm GPG-KEY

CMD ["su", "-"]
