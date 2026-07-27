#!/bin/bash
# audit.sh — basic Linux security audit: failed logins + world-writable files

echo "=== Failed SSH login attempts (last 50) ==="
grep "Failed password" /var/log/auth.log | tail -50

echo ""
echo "=== World-writable files under /etc ==="
find /etc -type f -perm -o+w 2>/dev/null
