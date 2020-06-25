FROM amazonlinux
ARG PYTHON_VERSION=37
ENV PYTHON_VERSION=${PYTHON_VERSION}
RUN yum -y install zip jq python${PYTHON_VERSION}
COPY pip_install.sh /pip_install.sh
ENTRYPOINT ["./pip_install.sh"]