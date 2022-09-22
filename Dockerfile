FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
RUN echo 'Initializing the execution of the Dockerfile.'