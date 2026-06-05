cd BOOT
./getbin.sh
cd ..
#cd CMD
#./getbin.sh
#cd ~/feos

dd if=/dev/zero of=feos.img bs=512 count=2880
dd if=BOOT/boot.bin of=feos.img bs=512 count=1 conv=notrunc
dd if=BOOT/boot2.bin of=feos.img bs=512 count=1 seek=1 conv=notrunc
#dd if=CMD/main.bin of=feos.img bs=512 count=1 seek=2 conv=notrunc

#run in qemu
qemu-system-x86_64 -fda feos.img
