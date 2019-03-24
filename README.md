# HostBuster
Batch installs, whitelists, and sanitizes domains for your Linux hosts file.

## Usage:
### Required:
Text file containing newline-separated URLs to raw-text host files.
### Optional:
Text file containing newline-separated whitelist domains (may be substrings).

## Example:

### $ ./hostbuster.sh links.txt whitelist.txt
- or
### $ ./hostbuster.sh links.txt
*replaces /etc/hosts with newly processed one*



##### $ cat links.txt
https://raw.githubusercontent.com/EnergizedProtection/block/master/unified/formats/hosts.txt

https://raw.githubusercontent.com/EnergizedProtection/block/master/extensions/regional/formats/hosts.txt

https://raw.githubusercontent.com/EnergizedProtection/block/master/extensions/xtreme/formats/hosts.txt

https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts


##### $ cat whitelist.txt
facebook

fbcdn

twitter

reddit

## Notes:
- Please leave feedback, this is **work in progress**!
- Using hosts file bigger than several dozen megabytes **may** make your system **unstable**. In such a case, simply restart your system and write:
##### $ sudo rm /etc/hosts



- Websites usually have a corresponding CDN domain working along. You may want to whitelist those as well, as with the given example for **facebook** and **fbcdn**. You can try browser addons such as **uMatrix** to research websites before you apply the blocks system-wide with the hosts file.
- Recommended sources:

https://github.com/StevenBlack/hosts

https://github.com/AdroitAdorKhan/Energized

https://hosts-file.net/?s=Download
