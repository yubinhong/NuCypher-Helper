#!/bin/bash
echo -n "请输入密码："
read ALLINONEPWD
cd $HOME
sudo apt update
sudo apt upgrade -y
sudo apt install python3-dev build-essential libffi-dev python3-pip python3-venv -y
pip3 install -U wheel
pip3 install -U nucypher
sudo apt-get update && sudo apt update
sudo apt-get install software-properties-common -y
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get install ethereum -y
cd /root/ && mkdir ethereum
echo "运行eth节点，light模式"
nohup geth --rinkeby --syncmode "light" --datadir "/root/ethereum/" --cache=512 >/dev/null 2>&1 &
echo "创建worker地址"
echo -e "$ALLINONEPWD\n$ALLINONEPWD" | geth --datadir /root/ethereum/ account new
geth attach ipc:/root/ethereum/geth.ipc
