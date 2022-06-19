FROM maven:3.8.6-jdk-11-slim AS build

COPY src /home/app/src
COPY pom.xml /home/app

# Building the Service
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:11-jre-slim
# Getting the just created jar executable
COPY --from=build /home/app/target/eureka-server-0.0.1-SNAPSHOT.jar eureka-docker.jar

# Exposing it to port 8088
EXPOSE 8088 8088
ENTRYPOINT ["java","-jar","eureka-docker.jar"]
