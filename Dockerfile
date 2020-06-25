ARG PYTHON_VERSION=3.7
FROM lambci/lambda:build-python${PYTHON_VERSION}
ARG PYTHON_VERSION
ENV PYTHON_VERSION ${PYTHON_VERSION}
RUN yum -y install zip jq
COPY pip_install.sh /pip_install.sh
ENTRYPOINT ["/pip_install.sh"]