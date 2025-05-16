# usefull-cpanel-whm-server-scripts
---

# 1. 📬 Email Summary Script for cPanel/WHM Server

This script generates a daily report of emails **sent and failed** per cPanel user for the **past 7 days**, using data from the Exim mail log.

---

## ✅ Features
- Tracks outgoing emails and failures (`<=` and `**` in Exim logs)
- Groups email counts by **date** and **user**
- Saves report in a clean format in `email_report.txt`

---

## 📥 Installation

```bash
curl -o email_summary.sh https://raw.githubusercontent.com/RitikBarnwal/usefull-cpanel-whm-server-scripts/main/email_summary.sh
chmod +x email_summary.sh
./email_summary.sh
````
## 📥 The output will be saved in email_report.txt
```bash
cat email_report.txt
```

