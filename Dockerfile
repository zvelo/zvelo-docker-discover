FROM ubuntu:14.04

RUN apt-get update && apt-get install -y wget make gcc binutils python-pip python-dev libssl-dev libffi-dev

WORKDIR /root

RUN wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.3.tar.gz
RUN tar -zxvf haproxy-1.5.3.tar.gz

RUN cd haproxy-1.5.3 && make TARGET=generic && make install

RUN pip install python-etcd Jinja2
RUN touch /var/run/haproxy.pid

ADD . /app

WORKDIR /app

EXPOSE 1936

CMD ["python", "main.py"]

