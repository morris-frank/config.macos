PASS=""
sudo apt update
sudo apt install snapd
sudo snap install nextcloud
sudo nextcloud.manual-install morris $PASS
sudo nextcloud.occ config:system:set trusted_domains 1 --value=cloud.morris-frank.dev
sudo ufw allow 80,443/tcp
sudo nextcloud.enable-https lets-encrypt