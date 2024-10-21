FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app_backend

COPY backend/pom.xml ./
RUN mvn dependency:go-offline

COPY backend/src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app_backend

ENV SPRING_PROFILES_ACTIVE=docker

COPY --from=build /app_backend/target/ProjectOutlook-0.0.1-SNAPSHOT.jar backend.jar

# spring boot
EXPOSE 8080

CMD ["java", "-jar", "backend.jar"]
