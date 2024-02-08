# How-To: Configure Linux to auto-mount windows partition

Get your device UUID by running
```bash
 sudo blkid
```
Add a line to the end of `/etc/fstab`
``` bash
UUID=<YOUR_UUID>    /media/alex/Windows	ntfs	defaults,nls=utf8,umask=000,uid=1000,gid=1000,windows_names	0	0
```
This will mount the ntfs partition in read/write/execute permissions for the user and group. The permissions are fixed on mount so you have to give elevated permissions unless you want to unmount and remount to reset permissions.
