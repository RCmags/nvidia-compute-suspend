# Problem
Nvidia GPU causes the system to crash during and after suspends. The crash in irrecoverable
and creates a wall of text that indicates memory errors reguarding the GPU and VRAM.

# Steps to fix
Make the file `/etc/modprobe.d/nvidia.conf` and add:

```
options nvidia NVreg_PreserveVideoMemoryAllocations=0
```

The above prevents VRAM from being stored during suspend and creating a kernel error. 

Moreover, also dissable the Nvidia services that manage the suspend cycle:

```
sudo systemctl disable nvidia-suspend.service nvidia-resume.service nvidia-hibernate.service
```

Let the OS manage this as any other PCIe device. The combination of the above commands
provides maximum stability for the computer.

**See:**
https://forum.artixlinux.org/index.php/topic,7425.0.html

https://bbs.archlinux.org/viewtopic.php?id=297276

# Debugger:
https://support.exxactcorp.com/hc/en-us/articles/22071798306583-Generating-an-Nvidia-Bug-Report-using-nvidia-bug-report-sh
