# Ubuntu

Based on the official [Ubuntu](https://hub.docker.com/_/ubuntu) image, includes pre-installed basic softwares and basic system configurations.

- Init

```bash
git init
git add .
git commit -m "ubuntu"
git branch -M main
git remote add origin https://github.com/linjixing/ubuntu.git
git push -u origin main
```

## Versions

- Pull from [Docker Hub](https://hub.docker.com/repository/docker/linjixing/ubuntu/tags)

```bash
docker pull linjixing/ubuntu:22.04
```

```bash
docker pull linjixing/ubuntu:24.04
```

```bash
docker pull linjixing/ubuntu:25.10
```

- Pull from [Github Packages](https://github.com/linjixing/ubuntu/pkgs/container/ubuntu)

```bash
docker pull ghcr.io/linjixing/ubuntu:22.04
```

```bash
docker pull ghcr.io/linjixing/ubuntu:24.04
```

```bash
docker pull ghcr.io/linjixing/ubuntu:25.10
```

## Softwares

- ssh
- git
- curl
- wget
- unzip
- vim
- nano
- sudo
- cron
- nginx
- certbot
- supervisor
