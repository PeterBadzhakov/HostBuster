#!/bin/sh

# Required:
# Path to text file containing newline-separated URLs
# to hosts files (raw view).
# Optional:
# Path to text file containing newline-separated
# whitelist domains (may be substrings).
if [ -z "$1" ] || [ -n "$3" ]; then
	echo "Invalid arguments."
	echo "Usage: $0 <path to URLs file>"
	echo "Optional: $0 <path to URLs file> <path to whitelist file>"
	exit 1
fi

cd "$(dirname "$0")"
source_file="$1"
whitelist_file="$2"

# Append raw contents of each source URL
# into current compilation.
echo "=== Downloading lists. ===\n"

while read -r line; do
	wget "$line" -O raw.new
	cat raw.new >> raw.curr
	rm raw.new
done < "$source_file"
# Left: raw.curr

# Remove duplicate domains.
echo "=== Removing duplicates. ===\n"

sort -u raw.curr > raw.nodupes
rm raw.curr

# Apply whitelist (if necessary).
if [ -n "$whitelist_file" ]; then
	echo "=== Applying whitelist. ===\n"

	regex="("
	while read -r line; do
		regex="${regex}|${line}"
	done < "$whitelist_file"
	regex="${regex})"
	grep -vwE "$regex" raw.nodupes > hosts
	rm raw.nodupes
 else
	mv raw.nodupes hosts
fi

# Overwrite system hosts file.
echo "=== Replacing system hosts file. ===\n"

sudo cp hosts /etc/
# Left: hosts

# Final cleanup.
echo "=== Cleaning up. ===\n"
rm hosts


# Make changes take effect.
echo "=== Restarting network-manager service. ===\n"

sudo service network-manager restart

echo "=== All done. ===\n"
