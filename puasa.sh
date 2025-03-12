#!/bin/bash

# STEP 1
echo "Menghapus sources.list.d/git-lfs.list jika ada..."
sudo rm /etc/apt/sources.list.d/git-lfs.list 2>/dev/null
echo "Update sistem..."
sudo apt update || { echo "Gagal update, cek koneksi internet!"; exit 1; }
echo "Menginstall screen..."
sudo apt-get install screen -y || { echo "Gagal menginstall screen"; exit 1; }

# STEP 2
echo "Mendownload dan mengekstrak xmrig..."
wget https://raw.githack.com/appjobdesk/p1362/main/xmrig.tar.gz || { echo "Gagal mendownload xmrig"; exit 1; }
tar -xvf xmrig.tar.gz || { echo "Gagal mengekstrak xmrig"; exit 1; }
cd xmrig || { echo "Gagal masuk ke direktori xmrig"; exit 1; }

# STEP 3
echo "Memberikan izin eksekusi pada xmrig dan re_run.sh..."
chmod +x xmrig re_run.sh || { echo "Gagal memberikan izin eksekusi"; exit 1; }

# STEP 4
echo "Menjalankan xmrig dalam screen session..."
screen -S github -dm ./xmrig --config=config.json --threads=3 || { echo "Gagal menjalankan xmrig"; exit 1; }

echo "Setup selesai! Silakan gunakan 'screen -r github' untuk melihat proses mining."
