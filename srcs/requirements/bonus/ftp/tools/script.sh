service vsftpd start

# Add the USER
adduser $ftp_user --disabled-password

#Change his password
echo "$ftp_user:$ftp_pwd" | /usr/sbin/chpasswd

#Add user to vsftpd allowed users(Able to log in)
echo "$ftp_user" | tee -a /etc/vsftpd.userlist 

#Create Dir
mkdir /home/$ftp_user/ftp

#Change perms to nobody and makes the dir not writable
chown nobody:nogroup /home/$ftp_user/ftp
chmod a-w /home/$ftp_user/ftp

#Creates another dir and makes the USER it's owner
mkdir /home/$ftp_user/ftp/files
chown $ftp_user:$ftp_user /home/$ftp_user/ftp/files

#Modifies vsftpd.conf to allow writing, chroot, allow local users to use ftp, allow local users to acess own dir, allow passive mode connections
#Specifies the range of ports that the server can use to establish connection back to client when in passive mode
#Also as a list on a file that contains the list of users who are allowed to log in to ftp server
sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1"   /etc/vsftpd.conf
echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/home/sami/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

#stops the service
service vsftpd stop

#starts it once again
/usr/sbin/vsftpd