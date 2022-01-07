FROM ubuntu:16.04
    && echo off
    && echo "Wait for update complete..."
    && apt update && DEBIAN_FRONTEND=noninteractive apt install unzip wget curl -y \
    && echo "Install Ngrok" \
    && echo "Downloading QEMU" \
    && DEBIAN_FRONTEND=noninteractive apt install -y qemu-kvm \
    && [ -s lite11.qcow2 ] || wget -O lite11.qcow2 https://app.vagrantup.com/thuonghai2711/boxes/WindowsQCOW2/versions/1.0.2/providers/qemu.box >/dev/nul \
    && disk=$(df -h /tmp | tail -1 | awk '{print $4}') \
    && qemu-img resize lite11.qcow2 $disk \
    && availableRAMcommand="free -m | tail -2 | head -1 | awk '{print \$7}'" \
    && availableRAM=$(echo $availableRAMcommand | bash) \
    && custom_param_ram="-m "$(expr $availableRAM / 2 )"M" \
    && cpus=$(lscpu | grep CPU\(s\) | head -1 | cut -f2 -d":" | awk '{$1=$1;print}') \
    && custom_param_cpu=$(expr $cpus / 2 ) \
    && echo "QEMU-KVM Windows 11 by fb.com/thuong.hai.581" \
    && echo "$custom_param_cpu / $custom_param_ram" \
    && echo Your RDP IP Address: \
    && curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' \
    && echo User: Administrator \
    && echo Password: Thuonghai001 \
    && echo "Script by fb.com/thuong.hai.581 | Modify by HaiDang" \
    && echo Wait 1-2m VM boot up before connect. \
    && echo "qemu-system-x86_64 -net nic -net user,hostfwd=tcp::30889-:3389 -show-cursor $custom_param_ram -enable-kvm -cpu Cascadelake-Server,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,+nx -M pc -smp cores=$custom_param_cpu -vga std -machine type=pc,accel=kvm -usb -device usb-tablet -k en-us -drive file=lite11.qcow2,index=0,media=disk,format=qcow2 -boot once=d -vnc :0" > start.sh
CMD ["./start.sh"]
EXPOSE 80
EXPOSE 3389
EXPOSE 5900
