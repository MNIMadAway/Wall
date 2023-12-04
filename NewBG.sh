#!/bin/bash

#Необходимо прописать урл картинки в imgurl
#!/bin/bash
#Current dir variable
	salt="tNk)s"
	pstr="U2FsdGVkX1/RHIs4Gn01SSJKlo1yvuMLLZCwFotJaPI="
	cred=$(echo $pstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	oldpstr="U2FsdGVkX1+oIx2n7QFD/cd6UuXC9/WLbRehy/Y61kg="
	oldcred=$(echo $oldpstr | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -pass pass:$salt)
	curdir=$(dirname $(readlink -e "$0"))
	newdir=/usr/share
	imgurl="https://github.com/MNIMadAway/Wall/raw/main/wall"

#Passchange
	(echo $cred | su - dcadmin -c "echo $cred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $cred > /usr/share/temp") || (echo $oldcred | su - dcadmin -c "echo $oldcred | sudo -S install -m 777 /dev/null /usr/share/temp && echo $oldcred > /usr/share/temp") 
	pass=$(cat $newdir/temp)
	echo $pass | su - dcadmin -c "echo $pass | sudo -S rm $newdir/temp"





echo $pass | su dcadmin -c "echo $pass | sudo -S wget "$imgurl" -O /usr/share/backgrounds/wall"
echo $pass | su dcadmin -c "echo $pass | sudo -S sed -i "/background/c\background=/usr/share/backgrounds/wall" /usr/share/lightdm/lightdm-gtk-greeter.conf.d/*"
touch 1
echo -e "[greeter]\nuser-background = false\nhide-user-image = true" > 1
echo $pass | su dcadmin -c "echo $currentpass | sudo -S cp 1 /etc/lightdm/lightdm-gtk-greeter.conf"
rm 1
notify-send "Готово!"
rm -- "$0"
