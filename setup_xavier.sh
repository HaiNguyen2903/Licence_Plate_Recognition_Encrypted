# Update and upgrade system
sudo apt-get update && sudo apt-get upgrade

# Install pip3 and setup tool
sudo apt-get install -y --no-install-recommends python3-pip && sudo rm -rf /var/lib/apt/lists/* && apt-get clean

pip3 install --no-cache-dir testresources setuptools==56.2.0

# Install Go 1.19.1
wget https://go.dev/dl/go1.19.1.linux-arm64.tar.gz

sudo rm -rf /usr/local/go

sudo tar -C /usr/local -xvf go1.19.1.linux-arm64.tar.gz

sudo rm -rf go1.19.1.linux-arm64.tar.gz

# Install imgcrypt
git clone https://github.com/HaiNguyen2903/imgcrypt.git

cd imgcrypt

make 

sudo make uninstall

sudo make install

cd .. && sudo rm -rf imgcrypt

# Pull and encrypt images with private key
rm -rf docker_keys

mkdir docker_keys && cd docker_keys

# image
# https://drive.google.com/file/d/1sm66UNthEx-T5W_i7NHwTVi8e3rM82_X/view?usp=sharing

# private key
# https://drive.google.com/file/d/1SS-Au93MX0ThXrlUz-y3kAVeAK1zx4Zz/view?usp=sharing

# Import encrypted image
wget --load-cookies ../tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies ../tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1sm66UNthEx-T5W_i7NHwTVi8e3rM82_X' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1sm66UNthEx-T5W_i7NHwTVi8e3rM82_X" -O image.tar && rm -rf ../tmp/cookies.txt


wget --load-cookies ../tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies ../tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1SS-Au93MX0ThXrlUz-y3kAVeAK1zx4Zz' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1SS-Au93MX0ThXrlUz-y3kAVeAK1zx4Zz" -O prikey.pem && rm -rf ../tmp/cookies.txt

sudo ctr-enc images rm lpr_image.enc:latest --sync

sudo ctr-enc images import  --platform linux/arm64 --base-name lpr_image.enc-import --key prikey.pem --skip-decrypt-auth image.tar

sudo rm -rf image.tar

# openssl genrsa --out prikey.pem

# openssl rsa -in prikey.pem -pubout -out pubkey.pem

# sudo ctr-enc images rm lpr_image.enc:latest --sync

# sudo ctr-enc images pull --all-platforms docker.io/tranducanh7/lpr_image:latest

# sudo ctr-enc images encrypt jwe:pubkey.pem --platform linux/arm64 docker.io/tranducanh7/lpr_image:latest lpr_image.enc:latest

# sudo ctr-enc images rm docker.io/tranducanh7/lpr_image:latest --sync