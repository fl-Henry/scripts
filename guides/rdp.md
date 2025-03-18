### 1. **Install xrdp**
   ```bash
   sudo apt update
   sudo apt install xrdp -y
   ```

### 2. **Install a Desktop Environment**
   ```bash
   sudo apt install xfce4 xfce4-goodies -y
   ```

### 3. **Configure xrdp to use the XFCE desktop environment**
   Create or edit the file `/etc/xrdp/startwm.sh` to start the desktop environment:
   ```bash
   sudo vim /etc/xrdp/startwm.sh
   ```

   Add the following line to the end of the file, just before the `exec` line:
   ```vim
   startxfce4
   ```

### 4. **Start and enable the xrdp service**
   ```bash
   sudo systemctl start xrdp
   sudo systemctl enable xrdp
   ```

### 5. **Allow RDP through the firewall**
   ```bash
   sudo ufw allow 3389/tcp
   sudo ufw reload
   ```

### 6. **Connect to your VPS**
   Now you can connect to your VPS via RDP from a Windows machine or an RDP client on any platform.

   - **Windows:** Open the Remote Desktop Connection app (`mstsc`), and type in the IP address of your VPS. 
   - **Linux/Mac:** Use an RDP client like **Remmina** or **Microsoft Remote Desktop** (for Mac).

   The login screen should prompt you for your username and password. Enter your credentials, and you should be able to access your VPS through RDP.