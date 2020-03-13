echo “Welcome to Can I Drive?”
echo “Required files will be downloaded from Github”
git clone “https://github.com/davidkerr766/can-i-drive.git”
cd can-i-drive/src
echo “Required gems will now be installed”
bundle install
echo “Launching the application...”
ruby can_i_drive.rb
