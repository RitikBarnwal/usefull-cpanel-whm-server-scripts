#!/bin/bash
# Auto-Optimization Script for WHM/cPanel Server
# Author: Ritik Barnwal - Generated on 2025-05-16

echo "Starting WHM Optimization Tasks..."

# 1. Update system packages weekly
yum -y update

# 2. Clean Apache & LiteSpeed logs older than 7 days
find /usr/local/apache/logs -type f -name "*.log" -mtime +7 -exec rm -f {} \;

# 3. Optimize all MySQL databases weekly
mysqlcheck -o --all-databases -u root

# 4. Clear cPanel user cache files older than 7 days
find /home/*/.cagefs/tmp -type f -mtime +7 -exec rm -f {} \;

# 5. Restart services if server load > 20.0
LOAD=$(cut -d. -f1 /proc/loadavg)
if [ "$LOAD" -gt 20 ]; then
  echo "High Load Detected: $LOAD, Restarting services..."
  systemctl restart httpd
  systemctl restart mysql
fi

# 6. Clear /tmp directory (common cause of slow IO)
find /tmp -type f -atime +2 -delete

# 7. Run OPcache reset to refresh compiled PHP scripts
/usr/bin/php -r 'opcache_reset();'

# 8. Run ImunifyAV scan (if installed)
if command -v imunify-antivirus &> /dev/null; then
  imunify-antivirus malware scan all --auto-clean
fi

# 9. Run MySQLTuner weekly and save output
perl /usr/local/bin/mysqltuner.pl > /root/mysqltuner-weekly-report.txt

# 10. Restart LFD/CSF weekly
systemctl restart lfd
csf -r

echo "Optimization Tasks Completed."
