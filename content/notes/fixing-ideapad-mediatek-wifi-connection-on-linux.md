+++
title = "Fixing Ideapad MediaTek Wi-Fi on Linux"
description = "Fixing the inability to use Wi-Fi on Linux for the Ideapad laptops with a MediaTek network device."
date = 2025-06-08
insert_anchor_links = "heading"

[extra]
keywords = ["ideapad", "mediatek", "linux"]
code = true
+++

If you run the command `rfkill` you may see something like the following:
```
ID TYPE      DEVICE                 SOFT      HARD
 0 wlan      ideapad_wlan        blocked unblocked
 1 bluetooth ideapad_bluetooth   blocked unblocked
 ...
```

If you see that the WLAN device is soft-blocked, this is currently preventing you from using Wi-Fi.


### Temporary Solution
To temporarily unblock the Wi-Fi device, you can run the following command[^1]:
```
sudo rfkill unblock wlan
```

### Permanent Solution

To permanently unblock the your network device, you can add the following line to `/etc/modprobe.d/blacklist.conf`:
```
blacklist ideapad_laptop
```

Just create the file `/etc/modprobe.d/blacklist.conf` if it doesn't exist. Then restart your system.

After a restart, you can verify that the Wi-Fi device is unblocked by running the command `rfkill` again. It should now be possible for you to use `wpa_supplicant`, `iwctl`, `NetworkManager` or any other networking management tool[^2].

**NOTE:** You may also have to enable the `dbus` service.

---

[^1]: <https://askubuntu.com/a/678653>
[^2]: <https://askubuntu.com/a/1168636>
