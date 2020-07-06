# Changelogwatcher
A small script to monitor changelogs. Run daily and it will inform you about any updates.
The watchlist.csv file will take any changelogs in plain text format. Examples are included. The format is "Name,URL", where Name is the Name of the project (used as Header line in the mail). Do not use spaces in the name.

# install
This script has no install routine. You can just run it in any folder you like. Make sure the working directory has a subdir "logs".
To run this script automatically every day, you can install a cronjob:

0 8 * * * cd /home/jti/changelogwatcher ; /home/jti/changelogwatcher/watcher.sh >> /home/jti/changelogwatcher/watcher.log 2>&1
