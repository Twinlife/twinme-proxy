# Twinlife Proxy for twinme and Skred

When access to the app's signaling servers is blocked in your country, proxies can bypass these blocks in many circumstances and allow you to communicate privately.
In addition to the in-app proxies, you can create your own or use a proxy created by someone else.
Proxies cannot access the contents being exchanged under any circumstances.

To run a Twinlife proxy, you will need a host that has port 443 available and optionaly a domain name that points to that host.

1. Install Docker by following the instructions at https://docs.docker.com/engine/install/
2. Clone this repository
3. `docker compose up --detach`

Your proxy is now running! You can share this with these URLs:

- For twinme: `https://proxy.twin.me/#<your_host_name|IP>`
- For Skred: `https://proxy.skred.mobi/#<your_host_name|IP>`

## Updating from a previous version

If you've previously run a proxy, please update to the most recent version by pulling the most recent changes from `main`, then restarting your Docker containers:

```shell
git pull
docker compose down
docker compose build
docker compose up --detach
```

## Contributions welcome

We want this proxy to be simple to deploy for a broad population, but we know that it won’t fit all deployments—especially  advanced users that already have running servers or specific technology preferences. We welcome contributions that make incremental improvements, updates, and improve compatibility, but aren’t considering significant architectural changes.


## Credits

Our Twinlife proxy is a simplified version of the excellent [Signal TLS proxy](https://github.com/signalapp/Signal-TLS-Proxy).
The main difference is that Twinlife proxy don't require to setup a Let's encrypt certificate nor a domain name.
The drawback is that the TLS handshake will still show the connection to our servers.

