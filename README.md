# VHostWPort

This is just an ease-of-life script for local domain name resolution that includes port information as well.

Normally, we are unable to add port information to the `/etc/hosts` file as you can only mention the IP (ip + vhost_domains).

So, this simple bash script configures and starts a reverse proxy using apache which will allow to map target that have IP:PORT.

The script configuration is very basic and would have some little drawbacks, but it does the job.

### Requirements 
Just having `apache2` installed should allow this script to configure the reverse proxy with no issues

### Setup
Add the domain/vhost in `/etc/hosts` pointing to localhost

Modify the `ServerName` directive in the `VHostWPort.sh` script (Line 19 & 36) with the name the domain/vhost you need to resolve to.

Update this in both the `<VirtualHost *:80>` and `<VirtualHost *:443>` configuration nodes.

If Needed you can add more than one domain/vhost by adding multiple `ServerName` directive.

### Usage
```sh
./VHostWPort.sh 137.37.37.1:1337
```

### Discord
Feel free to reach out to me on discord if there are any issues. My ID is `scriptie`
