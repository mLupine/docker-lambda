FROM amazonlinux:2023

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin \
  PIPX_BIN_DIR=/usr/local/bin \
  PIPX_HOME=/usr/local/pipx

RUN chown root:root /tmp && \
    chmod 1777 /tmp && \
    yum install -y glibc-langpack-en && \
    yum groupinstall -y development && \
    yum install -y which clang cmake python-devel python3-devel docker && \
    python3 -m ensurepip && \
    yum clean all && \
    pip3 install pipx --no-cache-dir
