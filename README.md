# Nvidia GPU Compute Killer | Safe suspend for eGPU's on Linux
Linux Systemd service that kills any service that is using an Nvidia GPU's compute. This prevents
eGPU's from causing the computer to crash when suspending. Intended to be used with older laptops
using the "EXP GDC Beast" eGPU via express card.

# Installation 
Open your terminal inside this folder and run the commands shown below.

**nvidia-compute-suspend.sh**:
This script kills all nvidia GPU compute processes to prevent crashes when suspending an eGPU. 
Copy the file to expected location by running: 

```bash
sudo cp nvidia-compute-suspend.sh /usr/local/bin/nvidia-compute-suspend.sh
```

Then make executable by running:
```bash
sudo chmod +x /usr/local/bin/nvidia-compute-suspend.sh
```

**nvidia-compute-suspend.service**:
Place the file inside the services folder by running:

```bash
sudo cp nvidia-compute-suspend.service /etc/systemd/system/nvidia-compute-suspend.service
```

Then run:
```bash
sudo systemctl enable nvidia-compute-suspend.service
sudo systemctl start nvidia-compute-suspend.service
```

# Output
Suspend your computer then test the service by running:

```bash
sudo journalctl -xeu nvidia-compute-suspend.service
```

Then check the output messages. They should indicate the proceeses that were killed when the
computer was suspended.
