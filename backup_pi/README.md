# Requirements
    sudo apt-get install duplicity
    sudo pip install http://sourceforge.net/projects/py-gnupg/files/latest/download?source=files
# Cron
    sudo mv cron_backup_pi /etc/cron.d/
    sudo mv backup_pi.sh /usr/local/bin/
    sudo chmod +x /usr/local/bin/backup_pi.sh
