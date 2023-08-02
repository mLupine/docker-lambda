FROM mlupin/docker-lambda:java17-x86_64

FROM mlupin/docker-lambda:build-x86_64

ENV PATH=/var/lang/bin:$PATH \
  LD_LIBRARY_PATH=/var/lang/lib:$LD_LIBRARY_PATH \
  AWS_EXECUTION_ENV=AWS_Lambda_java17 \
  AWS_EXECUTION_ARCH=x86_64

COPY --from=0 /var/runtime /var/runtime
COPY --from=0 /var/lang /var/lang
COPY --from=0 /var/rapid /var/rapid

RUN mkdir /usr/local/gradle && curl -L -o gradle.zip https://services.gradle.org/distributions/gradle-8.2.1-bin.zip && \
  unzip -qd /usr/local/gradle gradle.zip && rm gradle.zip && mkdir /usr/local/maven && \
  curl -L https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz | \
  tar -zx -C /usr/local/maven

ENV PATH="/usr/local/gradle/gradle-8.2.1/bin:/usr/local/maven/apache-maven-3.9.3/bin:${PATH}"

# Add these as a separate layer as they get updated frequently
RUN pipx install awscli==1.* && \
  pipx install aws-lambda-builders==1.2.0 && \
  pipx install aws-sam-cli==1.15.0
