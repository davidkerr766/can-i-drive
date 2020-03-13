echo “Welcome to Can I Drive?”
echo “Lets begin the install now”
git clone “https://github.com/davidkerr766/can-i-drive.git”
cd can-i-drive/src
echo “Time to ensure all required gems are installed”
bundle install
echo “All gems have been installed, running application for the first time now”
ruby can_i_drive.rb
