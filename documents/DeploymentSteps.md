
### Create service

- Remove any existing service of the same name
```shell
sudo rm -f /etc/systemd/system/javaservice.service
```

- Copy the service file
```shell
sudo cp -f scripts/javaservice.service /etc/systemd/system/javaservice.service
```

- Reload the service daemon
```shell
sudo systemctl reload
```

- Enable the service to start on system startup
```shell
sudo systemctl enable javaservice.service
```

### Start Deployment

- Execute the deployment script:
```shell
sudo bash JavaServiceDeploy.sh 
```

