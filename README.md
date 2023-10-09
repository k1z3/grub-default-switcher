:hammer_and_wrench: GRUB default switcher
=========================================

-> [日本語 / ja](/README.ja.md)

:fire: Summary
--------------

**For GNU GRUB users in dual/multi-boot environments**, this script can **easily change the OS** to boot next time with **only a reboot**.

This script rewrites the menu number to be selected by default, which is written in `/boot/grub/grub.cfg`.

### :dart: Target User

- Users have difficulty accessing BIOS and GRUB (e.g., using a Bluetooth keyboard).

- Users who want to switch OS via remote access.

<img src="./image.gif" width="640">


:warning: Disclaimer
--------------------

***This script rewrites the GRUB config file (`/boot/grub/grub.cfg`) directly.***

***It may differ from the originally recommended usage.***

***I am not responsible for any disadvantage you may suffer from using this script, so please use it with caution.***


:pushpin: Specification
-----------------------

|  | GRUB default switcher |
| ---: | --- |
| License | MIT |
| Language | Shell script |
| Author | k1z3 |
| GitHub Repo. | https://github.com/k1z3/grub-default-switcher |



:sparkles: Usage
----------------

### :penguin: For Linux

0. (Optional) If you want to run without sudo, I recommend that you place `grub.cfg` in your home directory and make a symbolic link to it.

    First make a copy and back it up.

    ```bash
    cp /boot/grub/grub.cfg ~/grub.cfg
    cp /boot/grub/grub.cfg ~/grub.cfg.bk
    ```

    Next, delete the original `grub.cfg` file with sudo privileges.

    ```bash
    sudo rm /boot/grub/grub.cfg
    ```

    Finally, make a symbolic link to the copied file.

    ```bash
    ln -s /boot/grub/grub.cfg ~/grub.cfg
    ```

1. Clone this repository.

1. Running `main.sh` and the `config` file is automatically output.

    ```bash
    ./main.sh
    ```

1. Edit `config` file.

    - `cfgpath`: Absolute path to `grub.cfg` file.

    - `ubuntu`, `windows` etc. : Line number of each OS in the GNU GRUB menu.

        Note that ***line numbers in the GNU GRUB menu begin with 0***.

        It can also be called by any name (e.g. `archlinux`).

        Example:
        ```plane
        cfgpath="/home/k1z3/grub.cfg"

        ubuntu=0
        windows=4
        archlinux=5
        ```

1. You can switch by calling `main.sh` with the variable name you just set as an argument.

    ```bash
    ./main.sh windows
    ```

    Expected output:
    ```bash
    [Success] Changed default boot entry to 'windows'. (Index: 4)
    ```

1. Windows will be started at the next boot (reboot)! :tada:


### :window: For Windows

1. Prepare a Linux environment with GRUB in advance according to [the above procedure (For Linux)](#penguin-for-linux).

1. [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) environment is required for this script to work. Please install the appropriate distribution.

1. Mount Linux on WSL to edit `grub.cfg`.

    Run the following command in Cmd or Powershell to find a disk that can be mounted.

    ```powershell
    GET-CimInstance -query "SELECT * from Win32_DiskDrive"
    ```

    Example:
    ```powershell
    DeviceID           Caption          Partitions Size          Model
    --------           -------          ---------- ----          -----
    \\.\PHYSICALDRIVE0 M.2 NVMe SSD 2TB          3 2000396321280 M.2 NVMe SSD 2TB
    \\.\PHYSICALDRIVE1 M.2 NVMe SSD 1TB          2 1000202273280 M.2 NVMe SSD 1TB
    ```

    In this case, I have Linux with GRUB on 1TB, so I mount it as follows.

    ```powershell
    wsl --mount \\.\PHYSICALDRIVE1 --bare
    ```

    In addition, look for the partition number **on the WSL**.

    ```bash
    lsblk
    ```

    Example:
    ```bash
    NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    sda      8:0    0 363.3M  1 disk
    sdb      8:16   0     8G  0 disk [SWAP]
    sdc      8:32   0     1T  0 disk /snap
                                    /mnt/wslg/distro
                                    /
    sdd      8:48   0 931.5G  0 disk
    ├─sdd1   8:49   0     1G  0 part
    └─sdd2   8:50   0 930.5G  0 part
    ```

    The partition with `grub.cfg` is sdd2 (2nd), so mount it again **with Cmd or Powershell**.

    ```powershell
    wsl --mount \\.\PHYSICALDRIVE1 --partition 2
    ```

1. Go to WSL and clone this repository.

1. Running `main.sh` and the `config` file is automatically output.

    ```bash
    ./main.sh
    ```

1. Edit `config` file.

    - `cfgpath`: Absolute path to `grub.cfg` file (select the mounted one).

    - `ubuntu`, `windows` etc. : Line number of each OS in the GNU GRUB menu.

        Note that ***line numbers in the GNU GRUB menu begin with 0***.

        It can also be called by any name (e.g. `archlinux`).

        Example:
        ```plane
        cfgpath="/mnt/wsl/PHYSICALDRIVE1p2/home/k1z3/grub.cfg"

        ubuntu=0
        windows=4
        archlinux=5
        ```

1. You can switch by calling `main.sh` with the variable name you just set as an argument.

    ```bash
    ./main.sh ubuntu
    ```

    Expected output:
    ```bash
    [Success] Changed default boot entry to 'ubuntu'! (Index: 0)
    ```

1. Ubuntu will be started at the next boot (reboot). :tada:


## Confirmed to work

|  | GNU GRUB |
| ---: | :---: |
| 2.06 | :white_check_mark: |
