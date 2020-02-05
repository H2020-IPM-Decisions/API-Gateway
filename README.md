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

## Versioning

For the versions available, see the [tags on this repository](https://github.com/H2020-IPM-Decisions/API-Gateway/tags). 

## Authors

* **ADAS - Modelling and Informatics** - *Initial work* - [ADAS](https://www.adas.uk/)