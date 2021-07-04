resolution=$1

#1600x1200

sed -i -e "/GRUB_CMDLINE_LINUX_DEFAULT/ s/splash.*/splash video=hyperv_fb:$resolution\"/" /etc/default/grub
if [ -z $1 ]; then
    sed -i -e "/GRUB_CMDLINE_LINUX_DEFAULT/ s/splash.*/splash\"/" /etc/default/grub
fi
update-grub
echo "\nA reboot is required to applay this command\n"