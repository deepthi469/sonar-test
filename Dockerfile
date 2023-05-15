FROM quay.vapo.va.gov/vaaacelrodt/sonar-scanner-cli:latest

# Must be root user during container build
USER root

ADD sonar.crt /temp/sonar.crt

RUN echo -n | openssl s_client -connect sonarqube.apps.vapo.va.gov:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > sonar.crt

RUN openssl x509 -in sonar.crt -text

RUN keytool -import -trustcacerts -keystore /usr/lib/jvm/jre-11-openjdk/lib/security/cacerts -storetype jks -storepass changeit -noprompt -alias mycert -file /temp/sonar.crt

RUN yum upgrade -y
RUN yum install -y rpm-build


ENTRYPOINT [ "/bin/bash", "-c" ]
# CMD [ "/bin/bash" ]
