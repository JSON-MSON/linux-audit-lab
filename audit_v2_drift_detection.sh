#!/bin/bash
# audit.sh — with drift detection

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTDIR=~/audit_history
mkdir -p "$OUTDIR"

{
  echo "=== Failed SSH login attempts (last 50) ==="
  grep "Failed password" /var/log/auth.log | tail -50
  echo ""
  echo "=== World-writable files under /etc ==="
  find /etc -type f -perm -o+w 2>/dev/null
} > "$OUTDIR/audit_$TIMESTAMP.txt"

LATEST_PREV=$(ls -t "$OUTDIR"/audit_*.txt | sed -n '2p')

if [ -n "$LATEST_PREV" ]; then
  echo "=== Changes since last audit ($LATEST_PREV) ==="
  diff "$LATEST_PREV" "$OUTDIR/audit_$TIMESTAMP.txt"
else
  echo "No previous audit found — this is the baseline."
fi
