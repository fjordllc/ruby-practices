FROM debian:stable

RUN apt-get update \
	&& apt-get install -y \
	ssh \
	sudo

RUN mkdir /var/run/sshd
COPY ./sshd_config /etc/ssh/sshd_config

# test user
RUN useradd -m test \
	&& mkdir /home/test/.ssh
COPY ./authorized_keys /home/test/.ssh
RUN chown -R test:test /home/test/.ssh \
	&& chmod 700 /home/test/.ssh \
	&& chmod 600 /home/test/.ssh/authorized_keys

# root user
RUN mkdir /root/.ssh
COPY ./authorized_keys /root/.ssh
RUN chown -R root:root /root/.ssh \
	&& chmod 700 /root/.ssh \
	&& chmod 600 /root/.ssh/authorized_keys

EXPOSE 10022 22
CMD ["/usr/sbin/sshd", "-D"]
