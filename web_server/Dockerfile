FROM ubuntu as intermediate

MAINTAINER Nikolay Tyukaev

# install git
RUN apt-get update && \
	apt-get install -y git


# add credentials on build

ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
RUN chmod 700 ~/.ssh
RUN chmod 600 ~/.ssh/id_rsa

# make sure your domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
# RUN ssh -vT git@github.com

RUN git clone git@github.com:nvtyukaev/carstats.git

FROM ubuntu

ENV DJANGO /srv/carstats

RUN apt-get update && \
	apt-get install -y software-properties-common vim && \
	add-apt-repository ppa:jonathonf/python-3.6 && \
	apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv

# copy the repository from the previous image
COPY --from=intermediate /carstats ${DJANGO}

RUN cd ${DJANGO} && \
	pip3 install -r requirements.txt

EXPOSE 8000

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]