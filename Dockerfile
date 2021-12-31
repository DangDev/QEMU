FROM ubuntu:latest

RUN apt-get update \
    DEBIAN_FRONTEND=noninteractive apt install unzip wget curl sudo -y \
    wget -O ngrok-stable-linux-amd64.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && unzip -o ngrok-stable-linux-amd64.zip \
    ./ngrok authtoken $TOKEN \
    nohup ./ngrok tcp --region ap 30889 &>/dev/null & \
    DEBIAN_FRONTEND=noninteractive apt install -y qemu-kvm \
    [ -s lite11.qcow2 ] || sudo wget -O lite11.qcow2 https://app.vagrantup.com/thuonghai2711/boxes/WindowsQCOW2/versions/1.0.2/providers/qemu.box \
    disk=$(df -h /tmp | tail -1 | awk '{print $4}') \
    qemu-img resize lite11.qcow2 $disk \
    availableRAMcommand="free -m | tail -2 | head -1 | awk '{print \$7}'" \
    availableRAM=$(echo $availableRAMcommand | bash) \
    custom_param_ram="-m "$(expr $availableRAM / 2 )"M" \ 
    cpus=$(lscpu | grep CPU\(s\) | head -1 | cut -f2 -d":" | awk '{$1=$1;print}') \
    custom_param_cpu=$(expr $cpus / 2 )
CMD ["nohup sudo qemu-system-x86_64 -net nic -net user,hostfwd=tcp::30889-:3389 -show-cursor $custom_param_ram -enable-kvm -cpu Cascadelake-Server,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,+nx -M pc -smp cores=$custom_param_cpu -vga std -machine type=pc,accel=kvm -usb -device usb-tablet -k en-us -drive file=lite11.qcow2,index=0,media=disk,format=qcow2 -boot once=d -vnc :0"]
