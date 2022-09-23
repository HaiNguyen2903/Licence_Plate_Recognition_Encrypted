# Setup Tutorial on Jetson Xavier
## Requirements
- Architecture Support: ARM 64
- Jetpack Version     : 4.4.1

##  Setup steps:
**1. Clone code on Xavier device**
```bash
cd /home
git clone https://github.com/HaiNguyen2903/Licence_Plate_Recognition_Encrypted.git
```

**2. Install environment**
```bash
cd Licence_Plate_Recognition_Encrypted
bash setup_xavier.sh
```

**3. Install AI Engine and config file**
- Link Download: [Google Drive](https://drive.google.com/drive/folders/1re-W6LFmFziX7oRfgo_gOCxBXS4BS3m1?usp=sharing)
- The folder structure after setup should be as below:
```bash
root_folder (Licence_Plate_Recognition_Encrypted)
    |___AI_Engine
    |___arch_config.json
    |___ ...

```

**4. Setup config file for running AI engine**
In ```arch_config.json``` file, user need to change:
- ```img_dir```             : path to image folder need to be inferenced
- ```out_dir```             : path to output folder for visualization
- ```ip_address```          : Jetson Xavier device local IP address
- ```port```                : device port (default: 3000)
- ```MAC_address```         : device encrypted MAC address (Each device will be given an encrypted MAC address for verification)

**5. Create container for running Engine code**

Creating container for running 
```bash
sudo ctr-enc run --mount type=bind,src=/home/Licence_Plate_Recognition_Encrypted,dst=/home/Russian_LP_Test_Bench_V2/,options=rbind:rw --gpus 0 --net-host -t --rm --key docker_keys/prikey.pem lpr_image.enc:latest lpr_enc
```
Where ```src``` indicates root repo folder, ```dst``` indicates root folder in container. 

Running code inside container
```bash
cd /home/Russian_LP_Test_Bench_V2/
python3 deep_alpr_server.py --country {country_options}
```

Where ```country_option``` supports ```[korean, russian, japan]```.


<details>
<summary><h3>Warning: In case you cannot use encrypted code</h1></summary>

The setup steps are the same as above, except **step 2**: 

**2. Install environment**
```bash
cd Licence_Plate_Recognition_Encrypted
bash setup_and_encrypt.sh
bash setup_xavier.sh
```

</details>
