
# *********************
# * Compile script v0.2 *
# *********************
nasm -f bin boot.asm -o boot.bin

nasm -f bin boot2.asm -o boot2.bin
# for test in QEMU
#dd if=/dev/zero of=feos.img bs=512 count=2880

#dd if=boot.bin of=feos.img bs=512 count=1 conv=notrunc

#dd if=boot2.bin of=feos.img bs=512 count=1 seek=1 conv=notrunc

#qemu-system-x86_64 -fda feos.img

