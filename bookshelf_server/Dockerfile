FROM google/dart

ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH
ADD / /app/
WORKDIR /app/
RUN ["pub" , "get"]
CMD ["dart" , "web/webapp/main.dart"]