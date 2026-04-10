FROM docker.io/library/nginx:1.28-alpine

COPY deploy/xsd/ /data/xsd/
COPY deploy/conf/nginx-artifactory.conf /etc/nginx/conf.d/artifactory.conf
COPY deploy/conf/cors.conf /etc/nginx/cors.conf

RUN rm -f /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD DNS_IP=$(grep nameserver /etc/resolv.conf | awk '{print $2}' | head -n 1) && \
    sed -i "s/\${DNS_SERVER}/$DNS_IP/g" /etc/nginx/conf.d/artifactory.conf && \
    nginx -g 'daemon off;'
