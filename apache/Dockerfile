FROM oraclelinux:8
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40

COPY conf/ld.so.conf /etc/ld.so.conf

RUN yum -y update && \
    yum -y install httpd mod_ssl && \
    yum -y install libaio libaio-devel && \
    yum clean all

EXPOSE 80
EXPOSE 443
COPY conf/bashrc /etc/bashrc
COPY weblogic/mod_wl_24.so /etc/httpd/modules/mod_wl_24.so
COPY weblogic/libclntshcore.so /usr/local/lib/libclntshcore.so
COPY weblogic/libclntshcore.so.12.1 /usr/local/lib/libclntshcore.so.12.1
COPY weblogic/libclntsh.so /usr/local/lib/libclntsh.so
COPY weblogic/libclntsh.so.12.1 /usr/local/lib/libclntsh.so.12.1
COPY weblogic/libdms2.so /usr/local/lib/libdms2.so
COPY weblogic/libipc1.so /usr/local/lib/libipc1.so
COPY weblogic/libmql1.so /usr/local/lib/libmql1.so
COPY weblogic/libnnz12.so /usr/local/lib/libnnz12.so
COPY weblogic/libons.so /usr/local/lib/libons.so
COPY weblogic/libonsssl.so /usr/local/lib/libonsssl.so
COPY weblogic/libonssys.so /usr/local/lib/libonssys.so
COPY weblogic/mod_wl_24.so /usr/local/lib/mod_wl_24.so
RUN ldconfig 

COPY conf/ssl.conf /etc/httpd/conf.d/ssl.conf
COPY conf/httpd.conf /etc/httpd/conf/httpd.conf

COPY certs/cert.pem /etc/pki/tls/certs/cert.pem
COPY certs/privkey.pem /etc/pki/tls/private/privkey.pem
COPY certs/fullchain.pem /etc/pki/tls/certs/fullchain.pem


# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
