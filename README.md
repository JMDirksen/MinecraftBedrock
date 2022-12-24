# MinecraftBedrock
Bash scripts for running Minecraft Bedrock server

## Requirements
```
sudo apt install bash unzip curl wget screen grep
```

## Setup
```
cd ~
git clone https://github.com/JMDirksen/MinecraftBedrock.git
cd MinecraftBedrock
./update.sh
```

## Automation
```
crontab -e
  SHELL=/bin/bash
  @reboot (echo $(date) Start MinecraftBedrock; ~/MinecraftBedrock/start.sh) >> ~/cron.log 2>&1
  5 0 * * * (echo $(date) Restart MinecraftBedrock; ~/MinecraftBedrock/restart.sh) >> ~/cron.log 2>&1
  20 */3 * * * (echo $(date) Update MinecraftBedrock; ~/MinecraftBedrock/update.sh) >> ~/cron.log 2>&1
```
