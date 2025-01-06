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

インストール方法は以下が参考になります。   
余ったandroidスマホとTermuxでラジオ録音サーバを作ろう (13版)  
https://rfriends.hatenablog.com/entry/2023/07/18/210107  
