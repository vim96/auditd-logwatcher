import time

log_file = "/var/log/audit/audit-raw.log"
string1_to_watch = "tty=(none)"
string2_to_watch = "res=1"

with open (log_file, "r") as file, open("/var/log/audit/audit.log", "w") as file_modified:
    while True:
        for line in file:
            if string1_to_watch in line and string2_to_watch in line:
                line = line.replace(string2_to_watch, '')
            file_modified.write(line)
        file_modified.flush()
        time.sleep(1)