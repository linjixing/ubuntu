# Ubuntu 22.04

# Build and Push

```
docker build -t ubuntu .
docker tag ubuntu linjixing/ubuntu
docker login
docker push linjixing/ubuntu
```

# Usage

```
docker run -dit --name ubuntu -h ubuntu \
    -e USER=linjixing \
    -e RSA='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQ51EmSCCjZHF0JGaDeZai2B2GBMEhcB4VxggLm92J8qHiLAL+OXv6qjhDn8Ip1bOdedODI0/RLg6jLXdcg3IgeLnxDQ4MOk79k7terEbeR49Vln5oFkJjoiiVB4u6OsDPf3x2BEX7fCMPlUB2OQrmJbU1hTIZKZCq0kfQN1w4kIomPsqLLq/4x1lUtwZZm3pJMKv+pNq22NkSeFn8/cUIoSEgP7rQeRV7V8sWG87FtZTdr1bYEY6x8Bsijcqv+8ZASI0JKWklKT71VFSqd6CYwkL+1SUk4LOyI9DraxUEXMPdMc5fQgP7ZY8yz/I0d6UsEmXRLeu4GE7mEpjvqEeB' \
    -p 7681:7681 \
    linjixing/ubuntu
```

# Docs

- https://trzsz.github.io/cn/