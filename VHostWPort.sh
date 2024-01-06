#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <IP:PORT>"
    exit 1
fi

# Get the sudo token
echo "You need the sudo token to run this script"
sudo echo "sudo token acquired!"

filename="/etc/apache2/sites-available/vhostwport.conf"
url="$1"

sudo a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html ssl

virtual_host_content=$(cat <<EOF
<VirtualHost *:80>
    ServerName domain1.dev
    #ServerName domain2.dev
    ProxyPreserveHost On
    
    ProxyPass / http://$url/
    ProxyPassReverse / http://$url/

    ErrorLog \${APACHE_LOG_DIR}/vhostwport_error.log
    CustomLog \${APACHE_LOG_DIR}/vhostwport_access.log combined
</VirtualHost>

<VirtualHost *:443>

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

    ServerName domain1.dev
    #ServerName domain2.dev
    ProxyPreserveHost On
    
    SSLProxyEngine on
    SSLProxyCheckPeerName off
    ProxyPass / https://$url/
    ProxyPassReverse / https://$url/

    ErrorLog \${APACHE_LOG_DIR}/vhostwport-ssl_error.log
    CustomLog \${APACHE_LOG_DIR}/vhostwport-ssl_access.log combined
</VirtualHost>
EOF
)

sudo sh -c "echo '$virtual_host_content' > '$filename'"
echo "VirtualHost configuration written to $filename"

echo "Enabling the new site configuration"
sudo a2dissite 000-default.conf
sudo a2ensite vhostwport.conf

echo "Applying the changes"
sudo systemctl restart apache2

echo "All done. Don't forget to clear the browser cache!!!"
echo "Sayonara!"
