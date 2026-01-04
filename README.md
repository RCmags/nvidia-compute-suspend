# Safe suspend for Nvdia eGPU's on Linux
When an Nvidia GPU is connected to a laptop via an express card like the "Exp GDC Beast", the
video card drivers can cause Linux to crash under certain conditions. This is especially true 
when the computer is asked to suspend. This often leads to an irrecoverable crash on suspend or
wake that creates a wall of text that indicates memory errors regarding the GPU and VRAM.

# Steps to fix
Make the file `/etc/modprobe.d/nvidia.conf` and add:

```
options nvidia NVreg_PreserveVideoMemoryAllocations=0
```

The above prevents VRAM from being stored during suspend and creating a kernel error. 
Next, disable the Nvidia services that manage the suspend cycle:

```
sudo systemctl disable nvidia-suspend.service nvidia-resume.service nvidia-hibernate.service
```

The above commands greatly improves stability for the computer. It lets the OS manage the GPU
as any other PCIe device. Some warnings will likely be shown during suspend and wake, but the
computer will not crash and the GPU can continue to be used.


