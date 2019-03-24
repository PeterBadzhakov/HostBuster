# HostBuster
Batch installs, whitelists, and sanitizes domains for your Linux hosts file.

## Usage:
### Required:
Text file containing newline-separated URLs to raw text host files.
### Optional:
Text file containing newline-separated whitelist domains (may be substrings).

## Example:

### $ cat links.txt
https://raw.githubusercontent.com/EnergizedProtection/block/master/unified/formats/hosts.txt

https://raw.githubusercontent.com/EnergizedProtection/block/master/extensions/regional/formats/hosts.txt

https://raw.githubusercontent.com/EnergizedProtection/block/master/extensions/xtreme/formats/hosts.txt

https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts


### $ cat whitelist.txt
facebook

fbcdn

twitter

reddit



### $ ./hostbuster.sh links.txt whitelist.txt
*replaces /etc/hosts with a new, 37MB one*

### $ ls -l /etc/hosts
-rw-r--r-- 1 root root 37134357 Mar 24 23:10 /etc/hosts

## Notes:
Using hosts file bigger than several dozen megabytes **may** make your system **unstable**. In such a case, simply restart your system and write:
### $ sudo rm /etc/hosts
