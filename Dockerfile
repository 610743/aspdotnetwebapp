FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /aspdotnetwebapp

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /aspdotnetwebapp
COPY --from=build-env /aspdotnetwebapp/out .
ENTRYPOINT ["dotnet", "aspdotnetwebapp.dll"]