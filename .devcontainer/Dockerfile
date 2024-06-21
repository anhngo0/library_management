ARG VARIANT="17"

FROM openjdk:${VARIANT}
COPY target/*.jar library.jar

ENTRYPOINT ["java", "-jar", "library.jar"]

