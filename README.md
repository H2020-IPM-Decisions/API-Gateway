# H2020 IPM Decisions API Gateway

APS.NET Core Web API in charge to manage the different services of the H2020 IPM Decisions project.

## Branch structure

The project development will follow [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model where active development will happen in the develop branch. Master branch will only have release ans stable versions of the service.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

The API Gateway uses the following technologies:

```
ASP.NET Core 3.1.101
```
1. [Install](https://dotnet.microsoft.com/download/dotnet-core/3.1) the required .NET Core SDK.

### Getting the solution

The easiest way to get the sample is by cloning the samples repository with [git](https://git-scm.com/downloads), using the following instructions. As explained above, the develop branch is an active development branch, so checkout this branch to get the latest version.

```console
git clone https://github.com/H2020-IPM-Decisions/API-Gateway.git

cd API-Gateway

git checkout develop
```

You can also [download the repository as a zip](https://github.com/H2020-IPM-Decisions/API-Gateway/archive/master.zip).

### How to interact with the project

A [postman](https://www.getpostman.com/) collection has been created with the current end points available. 
Once the project is running, open the file `H2020.IPMDecisions.APG.Postman.json` using postman and you will be able to test the application.

## Creating a Docker Image locally

A Docker file has been created to allow to build and run the image in your preferred server. Before building your image ensure that your 'appsettings.json' is configured correctly.

***
**NOTE**
This docker build image doesn't include the Identity Provider, so you will need to configure the Ocelot files to redirect to the URL.
***

Remember to change the **EXPOSE** ports in the `Dockerfile` if the default ports are taken (80 and 443).
The following commands assumes that you are in the root directory of the application.
* The image created will be called: `ipmdecisions/apigateway`
* The container created will be called `APG` and will be running in the port `8087`
* The command bellow assumes that the URL port `H2020.IPMDecisions.APG.API\Properties\launchSettings.json` is 5002
```Console
docker build . --force-rm --pull -f ".\Docker\Dockerfile" -t "ipmdecisions/apigateway:latest"

docker run  -d -p 443:443/tcp -p 8087:5002/tcp --name APG ipmdecisions/apigateway:latest 
```
Now you should be able to user your API in the docker container.

## Deployment with Docker Compose

You can deploy the API Gateway, including the Identity Provider Service and a MySQL database with test data, using a docker compose.
A file called `docker-compose.yml` is located in the following folder `Docker` locate in the root folder of the project.

Before starting the solution you should modify the file with your information. We recommend to change the following data:
### Identity Provider Database
* On the `idp.db` (Identity Provider Database) service, change the value for the `MYSQL_ROOT_PASSWORD`

### Identity Provider API
* On the `idp.api` (Identity Provider API) service:
  - The gateway is expecting a hostname called **idp.api** that is running on the port **80**. If you wish to change the port, a new docker image will need to be built.
  - On the connection string, if you want to change the username and password, you will have to use change the [data loading script](MySQL_Init_Script/init.sql) line 32. Obviously, you can do this manually if you wish.
  - On the JwtSettings:SecretKey as unique string to sign the tokens e.g, `BFCVbbtvC1QoutaBujROE3cD_sRE3n16ohmM4sUQC0Q`. **This key will be shared with the API Gateway as it will be needed to validate the token**.
  - On the JwtSettings:IssuerServerUrl, enter the URL of the IDP. **This URL will be shared with the API Gateway as it will be in charge to validate the token**.
  - On the JwtSettings:ValidAudiencesUrls, a default valid client is added in the [data loading script](IDP_MySQL_Init_Script/init.sql) line 56, to allow you work with postman. Each time a new client is added into the database, you will need to reload the docker compose file. **This URL(s) will be shared with the API Gateway as it will be in charge to validate the token**.

### User Provision Database
* On the `upr.db` (User Provision Database) service, change the value for the `POSTGRES_USER` and `POSTGRES_PASSWORD`

### User Provision API
* On the `upr.api` (User Provision API) service:
  - The gateway is expecting a hostname called **upr.api** that is running on the port **80**. If you wish to change the port, a new docker image will need to be built.
  - On the connection string, if you want to change the username and password, you will have to use change the [data loading script](UPR_Postgresql_Init_Script/1.createUser.sql). Obviously, you can do this manually if you wish later.
  - On the JwtSettings:SecretKey as unique string to sign the tokens e.g, `BFCVbbtvC1QoutaBujROE3cD_sRE3n16ohmM4sUQC0Q`. **This key will be shared with the API Gateway as it will be needed to validate the token**.
  - On the JwtSettings:IssuerServerUrl, enter the URL of the IDP. **This URL will be shared with the API Gateway as it will be in charge to validate the token**.
  - On the JwtSettings:ValidAudiencesUrls, a default valid client is added in the [data loading script](IDP_MySQL_Init_Script/init.sql) line 56, to allow you work with postman. Each time a new client is added into the database, you will need to reload the docker compose file. **This URL(s) will be shared with the API Gateway as it will be in charge to validate the token**.

### API GateWay API
* For the `apg.api` (API GateWay API) service, you must match the same values as the `idp.api` on the following parameters:
  * JwtSettings:SecretKey
  * JwtSettings:IssuerServerUrl
  * JwtSettings:ValidAudiencesUrls
  * Also, you can add the type of claim values, in this case have been decide to have different `User access levels`.

Once you have configure your docker compose file,run the following command from your root directory:

```console
docker-compose -f "./Docker/Docker-compose.yml" up -d
```

If the default port has not been modified in the `apg.api`, the solution will be working in the URL `localhost:5002`, so you can check that the API works using the Postman collection.

The docker compose file will also load data into the database. Please read more about this in the [ReadMe.md](H2020.IPMDecisions.APG.API\Docker\ReadMe.md) file located in `Docker\IDP_MySQL_Init_Script`.

To help modifying the default data, a postman collection has been created with the calls needed. Also, please note that if a new Client is added into the database, this one will be needed added into the `H2020.IPMDecisions.APG.API\appsettings.Development.json`. You can achieve this modifying the `docker-compose.yml` file and running `docker-compose up -d` again.

## Versioning

For the versions available, see the [tags on this repository](https://github.com/H2020-IPM-Decisions/API-Gateway/tags). 

## Authors

* **ADAS - Modelling and Informatics** - *Initial work* - [ADAS](https://www.adas.uk/)