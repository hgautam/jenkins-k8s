Create a self signed certificate:

export DOMAIN=example.com; echo $DOMAIN

Wild card cert
openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout tls_self.key -out tls_self.crt -subj "/CN=*.${DOMAIN}" -days 365

SECRET_NAME=$(echo $DOMAIN | sed 's/\./-/g')-tls; echo $SECRET_NAME

Create kubernetes cert:
kubectl create secret tls $SECRET_NAME --cert=tls_self.crt --key=tls_self.key
