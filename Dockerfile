FROM jruby:9

WORKDIR /app

RUN apt-get update && \
    apt-get -y install ruby-full build-essential zlib1g-dev jq

RUN gem install bundler jekyll

RUN mkdir -p /root/.fhir/packages

COPY tools.json scripts/fetch_publisher_jar.sh /app/

RUN ./fetch_publisher_jar.sh

ENTRYPOINT ["java", "-jar", "/app/org.hl7.fhir.publisher.jar"]
CMD ["/bin/bash", "-c", "echo Welcome to the FHIR IG Publisher"]
