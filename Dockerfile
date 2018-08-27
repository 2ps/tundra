FROM centos:centos7
ARG work_dir=/tundra
ARG env_dir=/env
WORKDIR "${env_dir}"
COPY requirements.txt .
COPY docker/mariadb.repo /etc/yum.repos.d/
VOLUME "${work_dir}"
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum updateinfo \
  && yum makecache fast \
  # pip build dependencies
  # hiredis: gcc
  # mysqlclient: gcc zlib-devel openssl-devel
  && export build_deps='gcc zlib-devel python36u-devel openssl-devel MariaDB-devel' \
  && yum -y install python36u python36u-pip python-pip \
        MariaDB-client MariaDB-shared \
  && yum -y install ${build_deps} \
  && pip install virtualenv \
  && virtualenv . -p /usr/bin/python3.6 \
  && source bin/activate \
  && pip install -U --no-cache-dir pip \
  && pip install --no-cache-dir -r requirements.txt \
  && yum -y remove ${build_deps} \
  && yum -y remove MariaDB-release ius-release \
  && yum clean all
VOLUME "${work_dir}"
