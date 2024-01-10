ARG RUNTIME
ARG VERSION
FROM public.ecr.aws/lambda/${RUNTIME}:${VERSION} as amazonlinux

FROM mlupin/lambda-base-2023:build

ARG VERSION
ARG ARCH

ENV

COPY --from=amazonlinux /var/runtime /var/runtime
COPY --from=amazonlinux /var/lang /var/lang
COPY --from=amazonlinux /var/rapid /var/rapid

# Add these as a separate layer as they get updated frequently
RUN