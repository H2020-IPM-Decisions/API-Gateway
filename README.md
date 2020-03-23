# H2020 IPM Decisions API Gateway

APS.NET Core Web API in charge to manage the different services of the H2020 IPM Decisions project.

## Branch structure

The project development will follow [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) branching model where active development will happen in the develop branch. Master branch will only have release ans stable versions of the service.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

The API Gateway uses the following technologies:

```
ASP.NET Core 3.1
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
* The image created will be called: `h2020.ipmdecisions.apigateway`
* The container created will be called `APG` and will be running in the port `8087`
* The command bellow assumes that the URL port `H2020.IPMDecisions.APG.API\Properties\launchSettings.json` is 5002
```Console
docker build . --rm --pull -f ".\Docker\Dockerfile" -t "ipmdecisions/apigateway:latest"

docker run  -d -p 443:443/tcp -p 8087:5002/tcp --name APG ipmdecisions/apigateway:latest 
```
Now you should be able to user your API in the docker container.

## Deployment with Docker Compose

You can deploy the Identity Provider Service API, including a MySQL database with test data and a phpMyAdmin UI to manage the database, using a docker compose.
A file called `docker-compose.yml` is located in the following folder `Docker` locate in the rrot of the project. 
To run the following command:

```console
docker-compose -f "./Docker/Docker-compose.yml" up -d
```

If no data have been modified in the `docker-compose.yml` the solution will be working in the URL `localhost:8086`, so you can check that the API works navigating to `http://localhost:8086/swagger/index.html`

The docker compose file will also load data into the database. Please read more about this in the [ReadMe.md](H2020.IPMDecisions.IDP.API\Docker\MySQL_Init_Script\ReadMe.md) file located in `Docker\MySQL_Init_Script`.

To help modifying the default data, a postman collection has been created with the calls needed. Also, please note that if a new Client is added into the database, this one will be needed added into the `H2020.IPMDecisions.IDP.API\appsettings.Development.json`. You can achieve this modifying the `docker-compose.yml` file and running `docker-compose up -d` again.

## Versioning

For the versions available, see the [tags on this repository](https://github.com/H2020-IPM-Decisions/API-Gateway/tags). 

## Authors

* **ADAS - Modelling and Informatics** - *Initial work* - [ADAS](https://www.adas.uk/)