# VHostWPort

This is just an ease-of-life script for local domain name resolution that includes port information as well.

Normally, we are unable to add port information to the `/etc/hosts` file as you can only mention the IP (ip + vhost_domains).

So, this simple bash script configures and starts a reverse proxy using apache which will allow to map target that have IP:PORT.

### Requirements 
Just having `apache2` installed should allow this script to configure the reverse proxy with no issues

### Discord
Feel free to reach out to me on discord if there are any issues. My ID is `scriptie`
