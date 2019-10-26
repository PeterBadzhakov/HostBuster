#!/bin/sh

# Required:
# Path to text file containing newline-separated URLs
# to hosts files (raw view).
# Optional:
# Path to text file containing newline-separated
# whitelist domains (may be substrings).

if (( $# == 0 )) || (( $# >= 3 )); then
	echo "Invalid arguments.";
	echo "Usage: $0 <path to URLs file>";
	echo "Optional: $0 <path to URLs file> <path to whitelist file>";
	
	exit 1;
fi

source_file="$1";
whitelist_file="$2";

# Append raw contents of each source URL
# into current compilation.
echo "=== Downloading lists. ===";

rm -f ./raw.curr;
touch ./raw.curr;
for line in $(cat "$source_file"); do
	wget "$line" -O ->> ./raw.curr;
done
# Left: raw.curr

# Remove duplicate domains.
echo "=== Removing duplicates. ==="

sort -u ./raw.curr > ./raw.curr.sorted;
uniq ./raw.curr.sorted >./raw.nodupes;

rm ./raw.curr;
rm ./raw.curr.sorted;

# Apply whitelist (if necessary).
if [ "$whitelist_file" != "" ]; then
	echo "=== Applying whitelist. ===";

	regex="(";
	for line in $(cat "$whitelist_file"); do
		regex="$regex$line|";
	done
	regex="${regex::-1})";
	grep -vP "$regex" ./raw.nodupes 2>/dev/null 1>./hosts;
	rm ./raw.nodupes;
 else
	mv ./raw.nodupes ./hosts;
fi

echo "=== Replacing system hosts file. ===";

sudo mv ./hosts /etc/;
rm ./hosts;

echo "=== All done. ===";
