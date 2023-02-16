#!/bin/bash

python3 --version &> /dev/null
if [ "$?" -eq 0 ]
then
    python_version="/usr/bin/python3"
else
    python_version="/usr/bin/python"
fi

git --version &> /dev/null
if [ "$?" -eq 0 ]
then
    git clone https://github.com/vim96/auditd-logwatcher.git
    cd auditd-logwatcher/app/
    if [ "$python_version" = "/usr/bin/python3" ]
    then
        python_code_path=$(ls -d "$PWD/auditd_logwatcher-py3.py")
    elif [ "$python_version" = "/usr/bin/python" ]
    then
        python_code_path=$(ls -d "$PWD/auditd_logwatcher-py2.py")
    fi
else
    read -p "Please specify FULL PATH to the python code (e.g. /root/scripts/code.py): " python_code_path
fi

cat >> /etc/systemd/system/auditd-watchlog.service <<EOF
[Unit]
Description=Watch auditd raw logs for specific strings and replace them in order to avoid SEM triggers
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
Type=simple
ExecStart=$python_version $python_code_path
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

sed -i 's/log_file = \/var\/log\/audit\/audit.log/log_file = \/var\/log\/audit\/audit-raw.log/' /etc/audit/auditd.conf
/sbin/service auditd restart

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