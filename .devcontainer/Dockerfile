# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY pom.xml ./pom.xml

# Copy the rest of the application source code
COPY src ./src

# Add a volume to the /tmp directory
VOLUME /tmp

RUN mvn clean install -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the packaged jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Copy application.yml to the container
COPY ./src/main/resources/application.yml ./application.yml

# Expose the application port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
