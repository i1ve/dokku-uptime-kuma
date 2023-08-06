# dokku-uptime-kuma

References : https://github.com/louislam/uptime-kuma

This project contains Uptime Kuma that will be deployed as an app on a Dokku host.

## Run [Uptime Kuma](https://github.com/louislam/uptime-kuma) on Dokku host

### 1. Create kuma app

```sh
# Create app
dokku apps:create kuma

# Create persistent storage folder
sudo mkdir -p /var/lib/dokku/data/storage/kuma

```
Edit app docker-options:  
```sh
dokku docker-options:add kuma deploy,run "-v /var/lib/dokku/data/storage/kuma:/app/data"
```

### 2. Deploy kuma app

```sh
dokku git:sync --build kuma https://github.com/davmrtl/dokku-uptime-kuma.git main
```

### 3. Configure networking on kuma app

Map ports and add SSL using [dokku-letsencrypt](https://github.com/dokku/dokku-letsencrypt):
```sh
# Map ports
dokku config:set kuma DOKKU_PROXY_PORT_MAP="http:80:3001"

# Add SSL
dokku config:set --no-restart kuma DOKKU_LETSENCRYPT_EMAIL=your@email.tld
dokku letsencrypt:enable kuma

# Check if ports are mapped correctly
dokku config:get kuma DOKKU_PROXY_PORT_MAP

# Should output: "http:80:9000 https:443:9000"
```

