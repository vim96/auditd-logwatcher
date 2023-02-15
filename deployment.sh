#!/bin/bash

if [ $(git --version) - eq 0 ]
then
    git clone https://github.com/vim96/auditd-logwatcher.git
else
    read -p "Please specify FULL PATH to the python code (e.g. /root/scripts/code.py): " python_code_path
fi

sed -i 's/log_file = \/var\/log\/audit\/audit.log/log_file = \/var\/log\/audit\/audit-raw.log/' /etc/audit/auditd.conf
/sbin/service auditd restart

cat >> /etc/systemd/system/auditd-watchlog.service <<EOF
[Unit]
Description=Watch auditd raw logs for specific strings and replace them in order to avoid SEM triggers

[Service]
Type=simple
ExecStart=/usr/bin/python $python_code_path
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now auditd-watchlog.service

cat >> /etc/logrotate.d/auditd_watchlog <<EOF
/var/log/audit/audit.log {
    rotate 8
    size 10M
    compress
    missingok
    notifempty
    create 0644
    postrotate
        systemctl restart auditd-watchlog.service
    endscript
}
EOF