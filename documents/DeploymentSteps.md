# Deployment Steps

## 1. Build Project and Artifact

- Remove old build files, create a new build with a jar file, create a zip file containing the jar and other artifacts
```shell
# this command assumes that working from the code repository directory
./mvnw clean package
```


## 2. Move Artifact to Application Server Temp Location

- Move the zip file (e.g "JavaService-1.0_20231013141816.zip") found in `/target` of the code repository to the application server.
- Unzip the file to the temp directory `/tmp/JavaService`
```shell
sudo mkdir -pv /tmp/JavaService
sudo rm -r -f /tmp/JavaService/*
sudo unzip -o /tmp/JavaService-<version>_<timestamp>.zip -d /tmp/JavaService
sudo cd /tmp/JavaService
```


## 3. Create service (One Time)

- Remove any existing service of the same name
```shell
sudo rm -f /etc/systemd/system/JavaService.service
```

- Copy the service file
```shell
sudo cp -f /tmp/JavaService/scripts/JavaService.service /etc/systemd/system/JavaService.service
```

- Reload the service daemon
```shell
sudo systemctl daemon-reload
```

- Enable the service to start on system startup
```shell
sudo systemctl enable JavaService.service
```


## 4. Start Deployment

> Note: This step assumes that the service for the application is already enabled and running.

- Execute the deployment script:
```shell
sudo bash scripts/JavaServiceDeploy.sh <version>
```

---