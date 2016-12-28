FROM google/dart

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

ADD / /app/
WORKDIR /app/
RUN ["pub" , "get"]

RUN apt-get update && \
    apt-get install -y -q nginx supervisor && \
    rm -Rf /etc/nginx/sites-enabled/default && \
    rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD /localhost.conf /etc/nginx/conf.d/

CMD ["/usr/bin/supervisord"]