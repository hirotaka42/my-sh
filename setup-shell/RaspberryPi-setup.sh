#!/bin/bash

IP_ADDRESS='192.168.0.30/24'
ROUTERS='192.168.0.1'
DOMAIN_NAME_SERVERS='192.168.0.1'
HOSTNAME='raspberry'
# SSH接続用にGithubに登録してある公開鍵を転送する
# 使用する場合は 'None'から自分のIDに変更する
GITHUB_ID='hirotaka42'
SETTING_IP_FLAG=0
SETTING_PROMPT_FLAG=0
SETTING_GUI_FLAG=0

read -n1 -p "RaspberryPi Desktop版の設定を実行しますか? (y/N): " yn; case "$yn" in [yY]*) SETTING_GUI_FLAG=1;; *) echo " ";; esac
echo "設定ファイルをダウンロード"
mkdir ~/Github && cd ~/Github 
git clone https://github.com/hirotaka42/my-sh.git 

echo "IP_ADDRESS=${IP_ADDRESS}"
echo "ROUTERS=${ROUTERS}" 
echo "DOMAIN_NAME_SERVERS=${DOMAIN_NAME_SERVERS}" 
echo "HOSTNAME=${HOSTNAME}"

read -n1 -p "上記の内容でネットワーク設定を実行しますか? (y/N): " yn; case "$yn" in [yY]*) SETTING_IP_FLAG=1;; *) echo " ";; esac
read -n1 -p "プロンプトの設定をしますか? (y/N): " yn; case "$yn" in [yY]*) SETTING_PROMPT_FLAG=1;; *) echo " ";; esac

echo "タイムゾーンとロケーションの設定"
sudo raspi-config nonint do_change_timezone Asia/Tokyo 
sudo raspi-config nonint do_change_locale ja_JP.UTF-8 
sudo raspi-config nonint do_wifi_country JP 
sudo sed -i "s/deb.debian.org\/debian /ftp.jp.debian.org\/debian /g" /etc/apt/sources.list
echo "セットアップ"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y 
sudo apt install -y ntfs-3g cifs-utils git 
# viを消しVimをinstall
dpkg -l | grep vim 
sudo apt --purge remove -y vim-common vim-tiny 
sudo apt install vim -y 
# ssh接続用の公開鍵をGithubアカウントから取得
if [ ${GITHUB_ID} != 'None' ]; then
    ssh-import-id gh:${GITHUB_ID} 
else
    :
fi

if [ ${SETTING_PROMPT_FLAG} = '1' ]; then
    echo '-------------------------' 
    echo '0 ) install & change the shell ' 
    sudo apt install zsh -y 
    touch ~/.zshrc
    chsh -s /bin/zsh

    echo '-------------------------' 
    echo '1 ) install starship' 
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo '-------------------------' 
    echo '2 ) Setting starship.toml' 
    mkdir ~/.config && touch ~/.config/starship.toml 
    cp -f "$HOME/Github/my-sh/dotfiles/starship.toml" "$HOME/.config/starship.toml" 
    echo '-------------------------' 
    echo '3 ) install NerdFonts' 
    mkdir -p ~/.local/share/fonts 
    cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

else
    :
fi



if [ ${SETTING_IP_FLAG} = '1' ]; then
    echo 'IP固定化の設定' 
    echo 'interface eth0' | tee -a /etc/dhcpcd.conf 
    echo "static ip_address=${IP_ADDRESS}" | tee -a /etc/dhcpcd.conf 
    echo "static routers=${ROUTERS}" | tee -a /etc/dhcpcd.conf 
    echo "staitc domain_name_servers=${DOMAIN_NAME_SERVERS}" | tee -a /etc/dhcpcd.conf 
    sudo raspi-config nonint do_hostname ${HOSTNAME} 
    echo "IPアドレスは ${IP_ADDRESS}, ホストネームは ${HOSTNAME} に設定しました(再起動後に有効になります)" 
else
    :
fi

# Desktop app設定
if [ ${SETTING_GUI_FLAG} = '1' ]; then
    # 日本語入力 fcitx-mozc と vscode
    sudo apt install -y fcitx-mozc code
    echo '-------------------------' 
    echo '2.1 ) Setting Prompt' 
    # zshrc
    cp -f "$HOME/Github/my-sh/dotfiles/zshrc" "$HOME/.zshrc" 
    cp -f "$HOME/Github/my-sh/config/fcitx/config" "$HOME/.config/fcitx/config" 
else
    :
fi

#read -n1 -p "再起動しますか? (y/N): " yn; case "$yn" in [yY]*) sudo reboot;; *) echo "再起動がキャンセルされました";; esac
echo "再起動します"
sudo reboot
