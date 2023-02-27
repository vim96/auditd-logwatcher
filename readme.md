## **NOTE:**
## DO NOT DELETE THE PYTHON CODES AFTER THE INSTALLATION, THEY ARE USED BY SYSTEMD SERVICES

### If you want to store the codes in certain directory, please do that before running `deployment.sh`
#
## **Installation instructions**:

#
### **`Automatic way (requires git to be installed):`**

    git clone https://github.com/vim96/auditd-logwatcher.git
    cd auditd-logwatcher/
    chmod +x deployment.sh && bash deployment.sh

#
### **`Manual way:`**

1. Execute *`deployment.sh`*:

    ```bash
    bash <(curl https://raw.githubusercontent.com/vim96/auditd-logwatcher/staging/deployment.sh)
    ```

5. It will ask you for the path where you'd like to store the Python code