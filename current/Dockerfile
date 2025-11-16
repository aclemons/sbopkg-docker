# syntax=docker/dockerfile:1.20.0@sha256:26147acbda4f14c5add9946e2fd2ed543fc402884fd75146bd342a7f6271dc1d

FROM aclemons/slackware:current-full@sha256:281650e553227ae66b099b531c4c8d65c53009e318ed91a4bf5574003434bfe1

ARG TARGETARCH
RUN --mount=type=bind,source=current/docker-entrypoint.sh,target=/tmp/docker-entrypoint.sh \
    install -m0755 /tmp/docker-entrypoint.sh /docker-entrypoint.sh && \
    if [ "$TARGETARCH" = "386" ] ; then sed -i 's,exec su,exec /usr/bin/linux32 su,' /docker-entrypoint.sh ; fi

RUN wget --progress=dot:giga https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz && \
    bash -o pipefail -c 'printf "c302e306523b234bb025f1a74ee66d3037cfd25f2cc6ffd5f909e4d6278b5db6  sbopkg-0.38.2-noarch-1_wsr.tgz\n" | sha256sum --strict --check' && \
    installpkg sbopkg-0.38.2-noarch-1_wsr.tgz && \
    rm sbopkg-0.38.2-noarch-1_wsr.tgz && \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "D3076BC3E783EE747F09B8B70368EF579C7BA3B6" && \
    gpgconf --kill all && \
    sed -i '/REPO_BRANCH/s/-.*}/-current}/' /etc/sbopkg/sbopkg.conf && sed -i '/REPO_NAME/s/-.*}/-SBo-git}/' /etc/sbopkg/sbopkg.conf

# Until aarch64 is officially supported on SBo, try to find DOWNLOAD_aarch64 if
# someone has manually set one, if not, prefer the DOWNLOAD_x86_64 value if
# there is one, otherwise fallback to DOWNLOAD.
ARG TARGETARCH
RUN [ "$TARGETARCH" != "arm64" ] || patch -p2 <<"eof"
diff --git a/src/usr/sbin/sbopkg b/src/usr/sbin/sbopkg
index 4094cf9..f7522ff 100755
--- a/src/usr/sbin/sbopkg
+++ b/src/usr/sbin/sbopkg
@@ -2783,17 +2783,31 @@ read_info() {
     local i DOWNLOAD_ARCH DLSAVE MDSAVE REPLY
     local {DOWNLOAD,MD5SUM}_$ARCH

+    if [[ $ARCH == "aarch64" ]]; then
+      local {DOWNLOAD,MD5SUM}_x86_64
+    fi
+
     unset DOWNLOAD MD5SUM

     # Parse the .info file
     . $INFO
     # Assign the proper entries to DOWNLOAD and MD5SUM.
     DOWNLOAD_ARCH=$(eval echo \$DOWNLOAD_$ARCH)
-    if [[ -n $DOWNLOAD_ARCH ]]; then
-        DLSAVE=$DOWNLOAD
-        MDSAVE=$MD5SUM
-        DOWNLOAD=$DOWNLOAD_ARCH
-        MD5SUM=$(eval echo \$MD5SUM_$ARCH)
+    if [[ -z $DOWNLOAD_ARCH ]] && [[ $ARCH == "aarch64" ]]; then
+        DOWNLOAD_ARCH=$(eval echo \$DOWNLOAD_x86_64)
+        if [[ -n $DOWNLOAD_ARCH ]]; then
+            DLSAVE=$DOWNLOAD
+            MDSAVE=$MD5SUM
+            DOWNLOAD=$DOWNLOAD_ARCH
+            MD5SUM=$(eval echo \$MD5SUM_x86_64)
+        fi
+    else
+        if [[ -n $DOWNLOAD_ARCH ]]; then
+            DLSAVE=$DOWNLOAD
+            MDSAVE=$MD5SUM
+            DOWNLOAD=$DOWNLOAD_ARCH
+            MD5SUM=$(eval echo \$MD5SUM_$ARCH)
+        fi
     fi
     # Note: on SBo pre-13.0 repositories, as well as on current non-SBo
     # repositories, none of the above triggers. In that case, we use the
@@ -2824,7 +2838,7 @@ read_info() {
                     *) unknown_response ;;
                 esac
             done
-            if [[ $ARCH != "x86_64" ]]; then
+            if [[ $ARCH != "x86_64" ]] && [[ $ARCH != "aarch64" ]]; then
                 echo "DOWNLOAD=\"$DOWNLOAD_x86_64\"" >> $INFO
                 echo "MD5SUM=\"$MD5SUM_x86_64\"" >> $INFO
             else
eof

ENTRYPOINT ["/docker-entrypoint.sh"]
