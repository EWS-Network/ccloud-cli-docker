ARG ARCH=amd64
ARG OS=linux
ARG BASE_TAG=2
ARG BASE_IMAGE=public.ecr.aws/amazonlinux/amazonlinux:${BASE_TAG}

FROM $BASE_IMAGE as unzipper
WORKDIR /opt
RUN yum install tar gzip unzip -y
ADD https://s3-us-west-2.amazonaws.com/confluent.cloud/ccloud-cli/archives/latest/ccloud_latest_${OS:-linux}_${ARCH:-amd64}.tar.gz /opt/ccloud.tar.gz
RUN echo $URL
RUN tar -zxf ccloud.tar.gz

FROM $BASE_IMAGE
WORKDIR /opt
COPY --from=unzipper /opt/ccloud /opt/ccloud


ENTRYPOINT ["/opt/ccloud/ccloud"]
