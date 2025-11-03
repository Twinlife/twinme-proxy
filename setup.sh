#!/bin/bash
#

CONFIG_APP=
CUSTOM_SNI=
PROXY_IP=
NGINX_RELAY_CONFIG=nginx-proxy.conf
if test -f .env; then
    . .env
fi

/bin/echo -n "Which application are you using, skred or twinme ? ${CONFIG_APP} "
read APP
if test T${APP} = T; then
    APP=${CONFIG_APP}
fi
case $APP in
  skred|Skred)
     SERVER_NAME=ws.skred.mobi
     ;;

  twinme|twinme+)
     SERVER_NAME=ws.twin.me
     ;;

  *)
     echo "Application not supported: $APP"
     exit 1
     ;;
esac

echo "You can choose a SNI to increase the chance for your proxy to bypass censorship."
echo "The SNI will be visible to the proxy, firewalls and our server."
echo "Examples:"
echo " nothing.github.com"
echo " dead.microsoft.org"
echo " harley-is-best.davidson.com"
/bin/echo -n "What SNI do you want to use ? ${CUSTOM_SNI} "
read SNI
if test T${SNI} = T; then
    SNI=${CUSTOM_SNI}
fi

/bin/echo -n "What is the IP address of your proxy ? ${PROXY_IP} "
read IP
if test T${IP} = T; then
    IP=${PROXY_IP}
fi

echo ""
/bin/echo -n "Your proxy link is: "
case $APP in
  skred|Skred)
     echo https://proxy.skred.mobi/${IP}${PORT},${SNI}
     ;;

  twinme|twinme+)
     echo https://proxy.twin.me/${IP}${PORT},${SNI}
     ;;
esac

sed -e "s,SERVER_NAME,${SERVER_NAME},g" -e "s,CUSTOM_SNI,${SNI},g" < data/nginx-relay/nginx-template.conf > data/nginx-relay/nginx-proxy.conf

echo ""
echo "Your nginx configuration was created in data/nginx-relay/nginx-proxy.conf"
echo "Your configuration is saved in '.env' and you can change by running the setup script again."
echo "CONFIG_APP=${APP}" > .env
echo "CUSTOM_SNI=${SNI}" >> .env
echo "PROXY_IP=${IP}" >> .env
echo "NGINX_RELAY_CONFIG=nginx-proxy.conf" >> .env

echo ""
echo "To start your proxy, run:"
echo ""
echo "docker compose up --detach"


