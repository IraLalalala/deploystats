FROM ubuntu as intermediate

MAINTAINER Nikolay Tyukaev

# install git
RUN apt-get update && \
	apt-get install -y wget && \
	apt-get install -y git


# add credentials on build
RUN mkdir /root/.ssh/
RUN wget -O id_rsa https://www.dropbox.com/s/0nmtwrgwgpa7gpf/id_rsa?dl=1
RUN mv id_rsa /root/.ssh/id_rsa
RUN chmod 700 ~/.ssh
RUN chmod 600 ~/.ssh/id_rsa

# make sure domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
# RUN ssh -vT git@github.com

RUN git clone git@github.com:nvtyukaev/carstats.git
RUN git clone git@github.com:nvtyukaev/scrapestats.git

FROM ubuntu

ENV DJANGO /srv/carstats
ENV SCRAPER /srv/scraper

RUN apt-get update && \
	apt-get install -y wget && \
	apt-get install -y software-properties-common vim && \
	add-apt-repository ppa:jonathonf/python-3.6 && \
	apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv

# copy repositories from the previous image
COPY --from=intermediate /carstats ${DJANGO}
COPY --from=intermediate /scrapestats ${SCRAPER}



RUN wget -O secrets.json https://www.dropbox.com/s/47usx9g6rlegkx5/secrets.json?dl=1 && \
	cp secrets.json ${DJANGO} && \
	cd ${DJANGO} && \
	pip3 install -r requirements.txt

EXPOSE 8000

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["bash", "/docker-entrypoint.sh"]