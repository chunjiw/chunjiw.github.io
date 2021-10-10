@def title = "Beyond Ubuntu: Endeavour OS"
@def date = Date(2021, 10, 3)


I've been using Ubuntu for years.
While it is much better than Windows, it is not without flaws.
Over the years I encountered a few glitches, minor problems that though not enough to push me away from Linux, made my life a little bit troublesome.
Such as WiFi problems, not able to hibernate, not remember my dual monitor settings, monitor resolution problems, to list a few.
Most of the time, a reboot or unplug/re-plug would solve the problem ... it is just not ideal.

Eventually I could not endure the WiFi problem any more (always got disconnected for a minute or two after resuming from suspension), I installed Ubuntu 21.04 fresh, and everything worked great. 
I was quite happy with it, all problems that I encountered before seemed disappeared.
But it occurred to me then, why not try another distribution altogether?

I've set up the machine such that I can install multiple systems, so I rolled up sleeves and installed Endeavour OS to replace the old Ubuntu. 
Why Endeavour? 
It is only second to MX Linux on distrowatch, and MX Linux is based on Debian, same as Ubuntu.
So Endeavour should both be great and give me a fresh experience.

Oh I'm so glad I was right! Now I am writing this article in Endeavour OS, everything feels great.
But let me talk about a few hurdles I need to overcome first.

### Thunderbolt

Turns out thunderbolt devices need to be authorized before use.
Mouse and keyboard through thunderbolt do not work out of the box.
Gnome automatically prompt the user to authorize any thunderbolt device once connected,
but I installed Xfce first, and Xfce did not prompt me anything.
I needed to install `bolt` with 

```bash
pacman -S bolt
```
and list thunderbolt devices with `boltctl list`, and do 

```
boltctl enroll device-id
```

Then mouse and keyboard will work through thunderbolt.

### Xfce vs Gnome

Turns out Xfce somehow couldn't find my monitor (the same thunderbolt port) as an audio output device.
Very strange... Couldn't get Xfce to work, so I installed Gnome and it works fine!
I'm already quite familiar with Gnome since it is the default on Ubuntu. 
But since Endeavour is Arch, I got the most recent version, and it looks better than before.

### X11 vs Wayland

Wayland is the future. 
After installed Gnome, somehow I couldn't run Wayland on it.
Turns out the login manager (aka display manager) lightdm is a bit rough.
I enabled gdm (Gnome Display Manager), then, voila, problem solved.

### NFS drive mount at boot

Somehow a NFS drive, even though properly set up in `/etc/fstab`, still failed to mount at boot.
Boot log shows "mount.nfs4: Network is unreachable", even though I used option `_netdev` in `fstab`.
This one took quite some time to solve. 
Eventually I found this [forum post](https://forums.centos.org/viewtopic.php?t=52507) that solves the problem: add `comment=systemd.automount` option in `fstab`. 
Some places say `x-systemd.after=network-online.target` but it did nothing to my problem.

## Endeavour OS is great!

After fixing all problems, the system works like a charm, and really fast.

Installing software is snappy,
A few seconds most of the times.
I expected it to be so but I am still quite happy!

I also took this opportunity to learn some very basic tricks to do window tiling, so that I can reduce usage of mouse, to save my wrist:
~~~<kbd>Win</kbd>+<kbd>←</kbd>~~~ and ~~~<kbd>Win</kbd>+<kbd>→</kbd>~~~ to snap to full height and 50% width, ~~~<kbd>Win</kbd>+<kbd>↑</kbd>~~~ to full screen or maximize and ~~~<kbd>Win</kbd>+<kbd>↓</kbd>~~~ to restore the window to it’s previous size.
(I learned from [here](https://joshtronic.com/2018/09/09/why-i-dont-use-a-tiling-window-manager/))

With all these effort, I hope my productivity can shoot straight up 1 present!


