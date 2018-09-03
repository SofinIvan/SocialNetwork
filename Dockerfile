FROM java:8
MAINTAINER i.sofin@gmail.com
RUN mkdir -p /jars
ADD target/handshake*.jar /jars
CMD ["java", "-jar", "jars/handshake-0.0.1-SNAPSHOT.jar"]