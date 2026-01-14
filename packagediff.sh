#!/bin/bash

jq -r '.packages[] | .name' output/base.manifest | sort > /tmp/manifest_packages.txt
grep -v '^Listing' /usr/share/snow/snow.packages.txt | awk -F/ '{print $1}' | sort > /tmp/local_packages.txt
echo "Manifest packages: $(wc -l < /tmp/manifest_packages.txt)"
echo "Local packages: $(wc -l < /tmp/local_packages.txt)"
echo ""
echo "=== In MANIFEST but NOT on local system ==="
comm -23 /tmp/manifest_packages.txt /tmp/local_packages.txt
echo ""
echo "=== On LOCAL system but NOT in manifest ==="
comm -13 /tmp/manifest_packages.txt /tmp/local_packages.txt