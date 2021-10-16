FROM ubuntu:20.04
RUN apt update
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN apt install docker.io -y
RUN mkdir /home/app
COPY Dockerfile.runapp /home/Dockerfile
