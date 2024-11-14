FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app_backend

COPY backend/pom.xml ./
RUN mvn dependency:go-offline

COPY backend/src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app_backend

ENV SPRING_PROFILES_ACTIVE=docker

RUN apt-get update && apt-get install -y netcat && rm -rf /var/lib/apt/lists/*

COPY --from=build /app_backend/target/ProjectOutlook-0.0.1-SNAPSHOT.jar backend.jar

# spring boot
EXPOSE 8080
COPY dockerfiles/wait_db.sh /wait_db.sh
RUN chmod +x /wait_db.sh
CMD ["/wait_db.sh", "postgres_app", "5432", "java", "-jar", "backend.jar"]
