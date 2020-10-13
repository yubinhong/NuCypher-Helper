#!/bin/bash
echo -n "请输入 Infura WSS 链接："
read infura
echo -n "请输入 keystore 文件名，形如UTC--1970-01-01T13-16-00.690221616Z--eb2762dba37b1d98f45d73892af8216c37c3badd："
read keystore
echo -n "请输入 NUCYPHER_KEYRING_PASSWORD: "
read keyring_password
cd ~
echo "执行：nucypher ursula init --signer keystore:///$HOME/ethereum/keystore --provider $infura"
nucypher ursula init --signer keystore:///$HOME/ethereum/keystore --provider $infura
echo "启动 nucypher.service"
echo -e "[Unit]\nDescription="NuCypher Node"\n[Service]\nUser=$USER\nType=simple\nEnvironment="NUCYPHER_WORKER_ETH_PASSWORD=$keyring_password"\nEnvironment="NUCYPHER_KEYRING_PASSWORD=$keyring_password"\nExecStart=/usr/local/bin/nucypher ursula run\nRestart=always\nRestartSec=3\n[Install]\nWantedBy=multi-user.target" > nucypher.txt
sudo mv nucypher.txt /etc/systemd/system/nucypher.service
sudo systemctl daemon-reload
sudo systemctl enable nucypher
sudo systemctl start nucypher

