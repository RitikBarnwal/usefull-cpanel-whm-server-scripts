# 🚀 WHM/cPanel Server Optimization Script

**Automate your server maintenance, improve website speed, and boost WHM/cPanel performance!**

This bash script is designed for WHM/cPanel server administrators who want to automate common performance-related tasks. It helps free up resources, optimize services, clean logs, and monitor server health.

---

## 🔧 What It Does

| Task | Description |
|------|-------------|
| 🛠️ System Update | Updates system packages using `yum` |
| 🧹 Log Cleanup | Deletes Apache logs older than 7 days |
| 🧠 MySQL Optimization | Optimizes all MySQL databases using `mysqlcheck` |
| 🗑️ CageFS Cache Cleanup | Clears cached files in user `.cagefs/tmp` folders |
| ⚠️ High Load Monitor | Automatically restarts `httpd` and `mysql` if load > 20 |
| 🧼 Temp File Cleanup | Cleans `/tmp` to improve disk I/O |
| ⚡ OPcache Reset | Refreshes compiled PHP scripts for better speed |
| 🛡️ ImunifyAV Scan | Scans and cleans malware (if installed) |
| 📊 MySQLTuner Report | Runs MySQLTuner and saves the report weekly |
| 🔁 CSF/LFD Restart | Restarts firewall services weekly |

---

## 📥 Installation

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/yourusername/whm-optimization-script/main/whm_optimization_script.sh
    chmod +x whm_optimization_script.sh
   ./whm_optimization_script.sh
## ⏲️ Setup Cron Job (Automated Weekly Task)
    crontab -e
    0 2 * * 0 /bin/bash /root/whm_optimization_script.sh >> /var/log/whm_optimize.log 2>&1
## 🙌 Author
**Ritik Barnwal (RB)**
**Linux SysAdmin | cPanel Specialist**
📧 ritikbarnwal.in
🐙 GitHub: @RitikBarnwal

