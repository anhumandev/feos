## READTHIS!
Hello everyone. Thank you for taking the time to read this.
I looked back at the old days of computers. The time when we controlled computers with MS-DOS. Not like now when they controlled us. That's why I decided to create an operating system, albeit small. That would give us the same feeling.

FeOS is very small now and is just being written. You know, I don't have much time to write free code. Because I'm really busy. I'm also a math and physics student and a programmer. I wanted to see if you could help me or if you have any suggestions, maybe we can work on this together. If possible, go to GitHub and send me an email. If my explanation on GitHub was bad (I'm sorry about that), send me an email so I can let you know more.

In general, to all those who would like to help us improve this operating system. First, I would like to thank them, and then. I would like them to send me a message. Thank you very much.

Email address: anhumandev@gmail.com
(2) Email address : ahumandev@zoho.com
Github page: https://github.com/anhumandev/feos

P.S. FeOS currently supports 0 syscalls. Just like my social life.

# FeOS
A Simple OS written in ASM + Custom own lang.
current version: V0.1

# How to test it myself?feos 
First clone it with git <code>git clone https://github.com/anhumandev/feos</code>
Just run getfeimg.sh (dont forget to add chmod +x to it), it auto made all things and ended up with an .img file.

# About Source
## BOOT
In this folder bootlader (boot.asm) and kernel (an simple still unfinished shell - boot2.asm) be.
## INS
In this folder tools of Fe Shell then written in Fel (FeLang) be. (They are unfinished)
## TLS
In this folder translator of Felang (.fel -> .asm - NASM) exists. (unfinished and may have bugs.) 

## List of command's
1. <code>flush</code> clear screen
2. <code>offsystem</code> off computer via APM (for old pc's bro.)
3. <code>trinfo</code> Some information about shell (LFM)

## List of somethings then they is not finished
1. "A" mode in BootMenu (installer)
2. Fel (felang)
3. Support hard disk (it use floppy now)
