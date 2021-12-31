FROM ubuntu:latest

RUN apt-get update && apt-get install wget curl sudo -y
RUN wget https://raw.githubusercontent.com/DangDev/QEMU/main/W11
RUN chmod +x W11
CMD ["bash","W11"]
