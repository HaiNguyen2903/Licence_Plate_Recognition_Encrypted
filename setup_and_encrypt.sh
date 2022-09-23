cd ..

git clone https://github.com/HaiNguyen2903/Licence_Plate_Recognition

cd Licence_Plate_Recognition

pyarmor obfuscate --recursive deep_alpr_server.py

cp -r lp dist 
cp -r lp_result dist 
cp -r camera_config.json dist 
cp -r log dist
cp -r arch_config.json dist
cp -r FOTS/utils/lanms/adaptor.cpp dist/FOTS/utils/lanms
cp -r FOTS/utils/lanms/include dist/FOTS/utils/lanms 
cp -r FOTS/utils/lanms/lanms.h dist/FOTS/utils/lanms
cp -r FOTS/utils/lanms/Makefile dist/FOTS/utils/lanms

sudo mv dist ..

cd ..

sudo mv dist Licence_Plate_Recognition_Encrypted

rm -rf Licence_Plate_Recognition

cd Licence_Plate_Recognition_Encrypted

