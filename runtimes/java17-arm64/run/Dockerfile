FROM arm64v8/amazonlinux:2

RUN yum install -y tar gzip

RUN curl https://docker-lambda.s3.amazonaws.com/fs/java17-arm64.tgz | tar -zx -C /opt

FROM mlupin/docker-lambda:provided.al2-arm64
FROM mlupin/docker-lambda:base-arm64

ENV PATH=/var/lang/bin:$PATH \
    LD_LIBRARY_PATH=/var/lang/lib:$LD_LIBRARY_PATH \
    AWS_EXECUTION_ENV=AWS_Lambda_java17 \
    AWS_EXECUTION_ARCH=arm64

COPY --from=0 /opt/* /var/

COPY --from=1 /var/runtime/init /var/rapid/init

USER sbx_user1051

ENTRYPOINT ["/var/rapid/init", "--bootstrap", "/var/runtime/bootstrap", "--enable-msg-logs"]
