source env-imx8.sh

make O=build imx8mp_evk_defconfig
cp -v bl31.bin ./build/bl31.bin
cp -v lpddr4_pmu_train_1d_dmem_202006.bin ./build/
cp -v lpddr4_pmu_train_1d_imem_202006.bin ./build/
cp -v lpddr4_pmu_train_2d_dmem_202006.bin ./build/
cp -v lpddr4_pmu_train_2d_imem_202006.bin ./build/
export ATF_LOAD_ADDR=0x970000
make O=build
