## Excluding certain events from auditd logging
#
## **Installation instructions**:


### **`Manual way:`**

1. Download *`deployment.sh`*:

        curl -o deployment.sh https://raw.githubusercontent.com/vim96/auditd-logwatcher/staging/deployment.sh

2. Make the script executable:

        chmod +x deployment.sh

3. Identify the **Python version** installed on your system:

        python3 --version || python --version
    3.1 In case you use Python Version 3 or above:
    
        curl -o auditd_logwatcher-py3.py https://raw.githubusercontent.com/vim96/auditd-logwatcher/staging/app/auditd_logwatcher-py3.py
    3.2 In case you use Python Version 2:

        curl -o auditd_logwatcher-py2.py https://github.com/vim96/auditd-logwatcher/blob/staging/app/auditd_logwatcher-py3.py

4. Execute *`deployment.sh`*:

        bash deployment.sh

5. It will ask you for the path to the Python code

#
### **`Automatic way (requires git to be installed):`**

        git clone https://github.com/vim96/auditd-logwatcher.git
        cd auditd-logwatcher/
        chmod +x deployment.sh && bash deployment.sh

## **NOTE:**
## DO NOT DELETE THE PYTHON CODES AFTER THE INSTALLATION, THEY ARE USED BY SYSTEMD SERVICES

### If you want to store the codes in certain directory, please do that before running `deployment.sh`