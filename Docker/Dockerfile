FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base

ARG URL_EXPOSE_PORT=80
ARG URL_EXPOSE_PORT_HTTPS=443
ARG BUILDER_VERSION=latest
ARG RELEASE_DATE="2020-02-20"

LABEL h2020.ipmdecisions.apg.version=${BUILDER_VERSION} \
    vendor="RSK ADAS Ltd" \
    h2020.ipmdecisions.apgrelease-date=${RELEASE_DATE}

WORKDIR /app
EXPOSE ${URL_EXPOSE_PORT}
EXPOSE ${URL_EXPOSE_PORT_HTTPS}

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["H2020.IPMDecisions.APG.API/H2020.IPMDecisions.APG.API.csproj", "H2020.IPMDecisions.APG.API/"]
COPY ["H2020.IPMDecisions.APG.API/appsettingsTemplate.json", "H2020.IPMDecisions.APG.API/appsettings.json"]
RUN dotnet restore "H2020.IPMDecisions.APG.API/H2020.IPMDecisions.APG.API.csproj"

COPY . .
WORKDIR /src/H2020.IPMDecisions.APG.API
RUN dotnet build "H2020.IPMDecisions.APG.API.csproj" -c Release -o /app/build

WORKDIR /src/H2020.IPMDecisions.APG.API
FROM build AS publish
RUN dotnet publish "H2020.IPMDecisions.APG.API.csproj" -c Release -o /app/publish

FROM base AS final
ARG URL_PORT=5002
ARG URL_PORT_HTTPS=443

WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "H2020.IPMDecisions.APG.API.dll"]