#!/bin/ba sh

echo 'Starting Fail2Ban...'
echo

fail2ban-client set logtarget STDOUT
fail2ban-client status

# Start fail2ban in console mode
exec fail2ban-client -x -vv -f start 

#permissions
#setfacl -R -m u:10000:r /var/logs

#app
#exec gosu fail2ban-client -x -vv -f start
