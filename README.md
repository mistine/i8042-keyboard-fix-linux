# i8042-keyboard-fix-linux
A (pseudo) fix for i8042 controller driver that breaks keyboard/trackpad functionality on resume from suspend.

## Why would someone need this?
If your laptop's keyboard and/or trackpad doesn't work after resuming from suspend, maybe you'll need this.

You never had to fix this in older Linux kernels. However, in recent kernels it's broken. Broken for years now.

Other fixes would involve using `i8042.direct` and `i8042.dumbkbd`, which messes up the keyboard light (CapsLock, NumsLock etc) and is unacceptable for me. `i8042.reset` alone doesn't work.

## Usage
Assuming you have this bug, first you need to check whether you're applicable for this fix.
I'll look into fixing this with non-i8042 platforms soon.

Run the following command:
```sh
# dmesg | grep i8042
```
If your output contains something like this you can continue:
```sh
[    1.250445] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.250522] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.336095] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    4.758848] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input8
```
Download **keyboard-reset.sh** and place the file in `systemd/system-sleep` folder (for Arch, it's `/usr/lib/systemd/system-sleep/`).
Make the script executable:
```sh
# chmod a+x /usr/lib/systemd/system-sleep/keyboard-reset.sh
```
and you're done! Your keyboard/trackpad should now work when resuming from suspend.
