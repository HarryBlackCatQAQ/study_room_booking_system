# keep the java build stage on maven with temurin 21 to match the current project
FROM maven:3.9.11-eclipse-temurin-21 AS builder

# keep the build workspace explicit inside the image
WORKDIR /build

# copy the shared proto definitions first because the java service generates grpc classes from them
COPY proto /build/proto

# copy the maven wrapper metadata first for better docker cache reuse
COPY services/java-recommendation-service/.mvn /build/services/java-recommendation-service/.mvn
COPY services/java-recommendation-service/mvnw /build/services/java-recommendation-service/mvnw
COPY services/java-recommendation-service/pom.xml /build/services/java-recommendation-service/pom.xml

# keep the maven wrapper executable inside the build stage
RUN chmod +x /build/services/java-recommendation-service/mvnw

# download the java service dependencies before copying the full source tree
RUN cd /build/services/java-recommendation-service && ./mvnw -q -DskipTests dependency:go-offline

# copy the full java service source tree after dependency resolution is cached
COPY services/java-recommendation-service /build/services/java-recommendation-service

# build the runnable spring boot jar without running tests
RUN cd /build/services/java-recommendation-service && ./mvnw -q -DskipTests package

# keep the runtime stage on a lightweight temurin 21 jre image
FROM eclipse-temurin:21-jre

# keep the java application root explicit inside the runtime image
WORKDIR /app

# copy the built spring boot jar into the runtime image
COPY --from=builder /build/services/java-recommendation-service/target/*.jar /app/java-recommendation-service.jar

# document the internal grpc listening port
EXPOSE 5101

# start the java grpc service when the container launches
CMD ["java", "-jar", "/app/java-recommendation-service.jar"]
