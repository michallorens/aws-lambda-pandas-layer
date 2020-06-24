FROM quay.io/pypa/manylinux2014_x86_64
ARG PYTHON_VERSION=38
ENV PYTHON_VERSION=${PYTHON_VERSION}
RUN yum -y install jq rh-python${PYTHON_VERSION}
COPY pip_install.sh /pip_install.sh
ENTRYPOINT ["./pip_install.sh"]