import time
from io import open

log_file = u"/var/log/audit/audit-raw.log"
string1_to_watch = u"tty=(none)"
string2_to_watch = u"res=1"

with open (log_file, u"r") as file, open(u"/var/log/audit/audit.log", u"w") as file_modified:
    while True:
        for line in file:
            if string1_to_watch in line and string2_to_watch in line:
                line = line.replace(string2_to_watch, '')
            file_modified.write(line)
        file_modified.flush()
        time.sleep(1)