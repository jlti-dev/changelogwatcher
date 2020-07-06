#/bin/bash

today=$(date +%Y-%m-%d)
yesterday=$(date -d "yesterday" +'%Y-%m-%d')

# Read the input file and download all the changelogs
while read -r line

do
  echo $line
  name=${line%,*}
  url=${line##*,}
  curl -o "logs/$name-$today.txt" "$url"
  if ! cmp "logs/$name-$yesterday.txt" "logs/$name-$today.txt" >/dev/null 2>&1
  then
    echo "<h1>$name</h1>" > logs/$name.diff.txt
    echo ""  >> logs/$name.diff.txt
    diff "logs/$name-$yesterday.txt" "logs/$name-$today.txt" | sed 's/> /<br \/>/' >> logs/$name.diff.txt
    echo ""  >> logs/$name.diff.txt
  fi
done < watchlist.csv

if ls logs/*.diff.txt 1> /dev/null 2>&1
then

  echo "To: test@example.com" > mail.txt
  echo "Subject: Daily changelog update" >> mail.txt
  echo "From: changelog@example.com" >> mail.txt
  echo "Content-Type: text/html" >> mail.txt
  echo "MIME-Version: 1.0" >> mail.txt
  echo "" >> mail.txt
  cat logs/*.diff.txt >> mail.txt

  sendmail -vt < mail.txt

  rm mail.txt
  rm logs/*.diff.txt

fi

rm logs/*-$yesterday.txt
