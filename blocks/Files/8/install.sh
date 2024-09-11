# Made by \/\\\

installAquaTheme()
{
if [[ $(csrutil status) = "System Integrity Protection status: enabled." ]]; then
	echo "Disable SIP first!"
	exit 1
fi
sudo echo "SIP disabled, continuing..."

diskutil list
read -p "Find the target drive name in the list above (the one WITHOUT the - Data suffix), then enter the #s# values. Then, type them below: " diskNums

echo creating livemount folder.. 
mkdir ~/lvmnt > /dev/null 2>&1
sudo mount -o nobrowse -t apfs /dev/disk$diskNums ~/lvmnt

cd ~/Desktop
git clone https://github.com/VisualisationExpo/AquaLickX-Sonoma145Edition 

echo Copying Aqua.car
sudo cp AquaLickX-Sonoma145Edition/Aqua.car ~/lvmnt/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/

echo Copying VibrantLight.car
sudo cp AquaLickX-Sonoma145Edition/VibrantLight.car ~/lvmnt/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/

echo Copying DarkAqua.car
sudo cp AquaLickX-Sonoma145Edition/DarkAqua.car ~/lvmnt/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/

echo Copying VibrantDark.car
sudo cp AquaLickX-Sonoma145Edition/VibrantDark.car ~/lvmnt/System/Library/CoreServices/SystemAppearance.bundle/Contents/Resources/

echo Blessing the boot volume
sudo bless --mount ~/lvmnt --bootefi --create-snapshot
sudo bless --mount "$HOME/lvmnt/System/Library/CoreServices/" --setBoot --create-snapshot > /dev/null 2>&1

echo Installation successful! Reboot to apply changes.
}


installAquaIcons()
{
cd ~/Downloads
read -p "Find the target drive name in the list above (the one WITHOUT the - Data suffix), then enter the #s# values. Then, type them below: " diskNums
sudo mount -o nobrowse -t apfs /dev/disk$diskNums ~/lvmnt

echo "Copying App icons..."
sudo cp App\ Store.icns ~/lvmnt/System/Applications/App\ Store.app/Contents/Resources/AppIcon.icns
sudo cp Automator.icns ~/lvmnt/System/Applications/Automator.app/Contents/Resources/AppIcon.icns
sudo cp Calculator.icns ~/lvmnt/System/Applications/Calculator.app/Contents/Resources/AppIcon.icns
sudo cp Chess.icns ~/lvmnt/System/Applications/Chess.app/Contents/Resources/AppIcon.icns
sudo cp Contacts.icns ~/lvmnt/System/Applications/Contacts.app/Contents/Resources/AppIcon.icns
sudo cp Dictionary.icns ~/lvmnt/System/Applications/Dictionary.app/Contents/Resources/AppIcon.icns
sudo cp FaceTime.icns ~/lvmnt/System/Applications/FaceTime.app/Contents/Resources/AppIcon.icns
sudo cp FindMy.icns ~/lvmnt/System/Applications/Find\ My.app/Contents/Resources/AppIcon.icns
sudo cp Font\ Book.icns ~/lvmnt/System/Applications/Font\ Book.app/Contents/Resources/AppIcon.icns
sudo cp Home.icns ~/lvmnt/System/Applications/Home.app/Contents/Resources/AppIcon.icns
sudo cp Image\ Capture.icns ~/lvmnt/System/Applications/Image\ Capture.app/Contents/Resources/AppIcon.icns
sudo cp Launchpad.icns ~/lvmnt/System/Applications/Launchpad.app/Contents/Resources/AppIcon.icns
sudo cp Mail.icns ~/lvmnt/System/Applications/Mail.app/Contents/Resources/AppIcon.icns
sudo cp Maps.icns ~/lvmnt/System/Applications/Maps.app/Contents/Resources/AppIcon.icns
sudo cp Messages.icns ~/lvmnt/System/Applications/Messages.app/Contents/Resources/AppIcon.icns
sudo cp Mission\ Control.icns ~/lvmnt/System/Applications/Mission\ Control.app/Contents/Resources/AppIcon.icns
sudo cp Music.icns ~/lvmnt/System/Applications/Music.app/Contents/Resources/AppIcon.icns
sudo cp News.icns ~/lvmnt/System/Applications/News.app/Contents/Resources/AppIcon.icns
#sudo cp .icns ~/lvmnt/System/Library/Applications/.app/AppIcon.icns
sudo bless --mount ~/lvmnt --bootefi --create-snapshot
sudo bless --mount "$HOME/lvmnt/System/Library/CoreServices/" --setBoot --create-snapshot > /dev/null 2>&1
}


getWallpapers()
{
cd ~/Library/Application\ Support/com.apple.mobileAssetDesktop/
echo Downloading Mac OS X 10.0 wallpaper for 512pixels 
curl https://lmnt.me/archive/wallpapers/apple/quantum-foam/heic/quantum-foam-blue.heic --output Aqua.heic
}


echo This installer supports ONLY macOS Sonoma! It WILL break your system on any other macOS version!
echo
echo To install the theme, type t
echo To get the wallpapers, type w
echo To make a complete installation, type c
echo Any other action will abort.


read -p "	> "  usrInput
echo $usrInput
 
if [ $usrInput = "t" ]; then
	installAquaTheme
fi

if [ $usrInput = "w" ]; then
	echo w
	getWallpapers
fi

if [ $usrInput = "c" ]; then
	getWallpapers
	installAquaTheme
fi

if [ $usrInput = "i" ]; then
	installAquaIcons
fi