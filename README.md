rfriends_termuxはandroidスマートホン上にrfriends3をインストールするスクリプトです。  

termux-change-repo  
termux-setup-storage  
pkg update && pkg upgrade -y  
pkg install git -y  
cd ~/  
rm -rf rfriends_termux  
git clone https://github.com/rfriends/rfriends_termux.git  
cd rfriends_termux  
sh rfriends_termux.sh  
  
インストール方法は以下を参照してください。   
[余ったandroidスマホとTermuxでラジオ録音サーバを作ろう](https://github.com/rfriends/rfriends_termux/wiki)
